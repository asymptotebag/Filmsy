//
//  DetailsViewController.m
//  Flix
//
//  Created by Emily Jiang on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
    
//    [self.posterView setImageWithURL:posterURL];
    [self.posterView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        // response is nil if image is cached
        if (response) {
            NSLog(@"Not cached, fade in image");
            self.posterView.alpha = 0.0;
            self.posterView.image = image;
            [UIView animateWithDuration:0.3 animations:^{
                self.posterView.alpha = 1.0;
            }];
        } else { // image cached
            self.posterView.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        // what to do if it fails??
    }];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    NSURLRequest *bdRequest = [NSURLRequest requestWithURL:backdropURL];
//    [self.backdropView setImageWithURL:backdropURL];
    [self.backdropView setImageWithURLRequest:bdRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        if (response) {
            NSLog(@"Not cached, fade in");
            self.backdropView.alpha = 0;
            self.backdropView.image = image;
            [UIView animateWithDuration:0.4 animations:^{
                self.backdropView.alpha = 1;
            }];
        } else { // image cached
            self.backdropView.image = image;
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        // failure condition
    }];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.dateLabel.text = [@"Released: " stringByAppendingString:self.movie[@"release_date"]];
    self.ratingLabel.text = [@"Rating: " stringByAppendingString:[[self.movie[@"vote_average"] stringValue] stringByAppendingString:[@"/10 (" stringByAppendingString:[[self.movie[@"vote_count"] stringValue] stringByAppendingString:@")"]]]];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    [self.dateLabel sizeToFit];
    [self.ratingLabel sizeToFit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
