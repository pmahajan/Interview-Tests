//
//  ViewController.m
//  PhotoGallery
//
//  Created by Sachin Patil on 24/08/15.
//  Copyright (c) 2015 Cuelogic Technologies. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "ServiceManager.h"
#import "JsonParser.h"
#import "GalleryModel.h"

static NSString *cellIdentifier = @"tableCell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic)NSMutableArray *imagesArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"image" object:nil];
}

-(void) receiveTestNotification:(NSNotification*)notification
{
    if ([notification.userInfo isKindOfClass:[NSDictionary class]])
    {
        _selectedImage.image = [notification.userInfo objectForKey:@"image"];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getImagesFromServer];
}

-(void)getImagesFromServer
{
    _imagesArray = [[NSMutableArray alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",baseUrl,endString];
    [[ServiceManager sharedInstance] getImagesFromServerWithUrl:urlString callBackBlock:^(NSData *jsonData, NSError *error) {
        if (jsonData)
        {
            NSError *err = nil;
            id jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&err];
            _imagesArray = [[JsonParser sharedInstance] parseTheJsonResponse:jsonResponse];
            [_tableView reloadData];
        }
        else
        {
            //Error;
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_imagesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    GalleryModel *model = [_imagesArray objectAtIndex:[indexPath section]];
    [cell setCollectionData:model.imgArray];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    GalleryModel *model  = [_imagesArray objectAtIndex:section];
    NSString *header = [model.array objectAtIndex:0];
    return header;
}

-(void)setImageOnView:(UIImage *)image
{
    _selectedImage.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
