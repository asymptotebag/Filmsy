//
//  MoviesViewController.m
//  Flix
//
//  Created by Emily Jiang on 6/23/21.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *filteredMovies;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MoviesViewController

//NSString *CellIdentifier = @"MovieCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    [self.activityIndicator startAnimating];
    
    [self fetchMovies]; // fetch movies once screen loads
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
//    [self.activityIndicator stopAnimating];
}

- (void)fetchMovies {
    // API key: 856048063001a4a1f07f6980906a4a90
    // Networking code:
    [self.activityIndicator startAnimating];
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
               
               self.movies = dataDictionary[@"results"]; // Store the movies in a property to use elsewhere
               self.filteredMovies = self.movies;
               
               self.titles = [[NSMutableArray alloc] init];
               for (NSDictionary *movie in self.movies) {
//                   NSLog(@"%@", movie[@"title"]);
                   [self.titles addObject:movie[@"title"]];
               }
               NSLog(@"Movies fetched");
               [self.tableView reloadData]; // Reload your table view data
           }
            [self.refreshControl endRefreshing]; // need to tell the refresh animation to stop/exit refresh state
            [self.activityIndicator stopAnimating];
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [[UITableViewCell alloc] init];
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
//    cell.posterView.image = nil;
//    [cell.posterView setImageWithURL:posterURL];
    
    // try to fade images in:
    [cell.posterView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        // response is nil if image is cached
        if (response) {
//            NSLog(@"Not cached, fade in image");
            cell.posterView.alpha = 0.0;
            cell.posterView.image = image;
            [UIView animateWithDuration:0.3 animations:^{
                cell.posterView.alpha = 1.0;
            }];
        } else { // image cached
            cell.posterView.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        // what to do if it fails??
    }];
    
    // cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColor.systemGray6Color;
    cell.selectedBackgroundView = bgView;
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject localizedCaseInsensitiveContainsString:searchText];
        }];
//        self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
        NSArray *filteredTitles = [self.titles filteredArrayUsingPredicate:predicate];
        NSMutableArray *searchResults = [[NSMutableArray alloc] init]; // temporary
        // rebuild filteredMovies. in loop, if filtered title matches movie title, add movie OBJECT (dict) to search results
        for (NSDictionary *movie in self.movies) {
            for (NSString *title in filteredTitles) {
                if (title == movie[@"title"]) {
                    // adding to search results
                    [searchResults addObject:movie];
                }
            }
        }
        self.filteredMovies = searchResults;
        
    } else {
        self.filteredMovies = self.movies;
    }
    [self.tableView reloadData]; // reload so only search results are shown
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    
    // go back to viewing all movies
    self.filteredMovies = self.movies;
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // sender is a generic ios word meaning the object that fired the event, here id is the tableview cell that was tapped
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

@end
