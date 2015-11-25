//
//  ViewController.m
//  PictureViewer
//
//  Created by ROBERA GELETA on 4/18/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//

#import "ViewController.h"
#import "RGSeeView.h"
#import "RGImageViewController.h"
#import "RGCollectionViewCell.h"

#define CELL_REUSE @"dummyImage"
@interface ViewController ()<RGImageViewControllerDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *demoImageView;
@property (nonatomic) RGImageViewController *imagePickerController;
@property RGSeeView *mainView;

@property UICollectionView *collectionView;
@property NSArray *imageNameList;

@end

@implementation ViewController
{
    BOOL tapped;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //hardcoded values for demoish
    self.imageNameList = @[@"i1",@"i2",@"i3",@"i4"];

    self.view.backgroundColor = [UIColor colorWithRed:0.25 green:0.36 blue:0.62 alpha:1];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [self.view addGestureRecognizer:tapGesture];
}



/**
 *  FOR FUN DEMO
 */

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[RGCollectionViewCell class] forCellWithReuseIdentifier:CELL_REUSE];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.view addSubview:self.collectionView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)tapped
{
    self.imagePickerController =  [[RGImageViewController alloc] init];

    [self presentViewController:self.imagePickerController animated:YES completion:^{
    }];

}



- (UIImageView *)sourceImageView
{
    return self.demoImageView;
}

- (void)finsihedSeeing:(BOOL)value
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)present:(id)sender {
    self.imagePickerController =  [[RGImageViewController alloc]init];
    [self presentViewController:self.imagePickerController animated:NO completion:^{
    }];
}


#pragma mark - Collection View Data Source 

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.imageNameList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGCollectionViewCell *castedCell = (RGCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
    NSString *imageName = self.imageNameList[indexPath.row];
    castedCell.cellImageView.image = [UIImage imageNamed:imageName];
    return castedCell;
}


#pragma mark - Collection View Delegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Lazy Loading

- (RGImageViewController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[RGImageViewController alloc] init];
        _imagePickerController.transitioningDelegate = self.imagePickerController;
        _imagePickerController.isPresenting = YES;
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}

@end
