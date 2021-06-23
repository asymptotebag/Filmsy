//
//  MoviesGridViewController.m
//  Flix
//
//  Created by Emily Jiang on 6/23/21.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchMovies];
    
    // SET UP COLLECTION VIEW LAYOUT CODE
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing*(postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchMovies {
    // API key: 856048063001a4a1f07f6980906a4a90
    // Networking code:
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=856048063001a4a1f07f6980906a4a90"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // when network call is finished
           if (error != nil) { // error happened
               NSLog(@"ERROR PRINTED HERE:%@", [error localizedDescription]);
               if ([error code]==-1009) {
                   // network connectivity error
                   NSLog(@"CAUGHT NETWORK CONNECTION ERROR");
                   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot Load Movies" message:@"The Internet connection appears to be offline." preferredStyle:UIAlertControllerStyleAlert];
                   UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       //handle try again action
                       [self fetchMovies]; // idk recursive try again?
                   }];
                   [alert addAction:retryAction];
                   
                   [self presentViewController:alert animated:YES completion:^{}];
               }
           }
           else { // API gave us smth back
               // Get the array of movies
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
//               NSLog(@"%@", dataDictionary);
               
               self.movies = dataDictionary[@"results"];
               [self.collectionView reloadData];
           }
       }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

@end
