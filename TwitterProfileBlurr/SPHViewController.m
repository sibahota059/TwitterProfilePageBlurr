//
//  SPHViewController.m
//  TwitterProfileBlurr
//
//  Created by Siba Prasad Hota  on 1/3/14.
//  Copyright (c) 2014 Wemakeappz. All rights reserved.
//

#import "SPHViewController.h"
#import "listCell.h"
#import "UIImage+StackBlur.h"

#define HeaderHeight 200.0f

@interface SPHViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SPHViewController



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    source=[UIImage imageNamed:@"sampleImage.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:source];
    self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, HeaderHeight);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HeaderHeight)];
    tableHeaderView.backgroundColor = [UIColor purpleColor];
    [tableHeaderView addSubview:self.imageView];
    self.tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listCell  *cell = (listCell *)[self.tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"listCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    cell.titleLabel.text=[NSString stringWithFormat:@"Title %d",indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UIScrollView delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.imageView.image=[source stackBlur:(-scrollView.contentOffset.y/12)];
    
    NSLog(@"height= %f",-scrollView.contentOffset.y);
    
    CGFloat yPos = -scrollView.contentOffset.y;
    if (yPos > 0) {
        CGRect imgRect = self.imageView.frame;
        imgRect.origin.y = scrollView.contentOffset.y;
        imgRect.size.height = HeaderHeight+yPos;
        self.imageView.frame = imgRect;
       
    }
}



@end
