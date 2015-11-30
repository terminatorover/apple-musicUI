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

@property (nonatomic) RGImageViewController *imagePickerController;
@property RGSeeView *mainView;

@property UICollectionView *collectionView;
@property NSArray *imageNameList;

@end

@implementation ViewController
{
    BOOL tapped;
    NSIndexPath *selectedIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //hardcoded values for demoish
    self.imageNameList = @[@"i1",@"i2",@"i3",@"i4",@"i1",@"i2",@"i3",@"i4",@"i1",@"i2",@"i3",@"i4",@"i2",@"i3",@"i4",@"i1",@"i2",@"i3",@"i4"];

    [self setupCollectionView];
}



/**
 *  FOR FUN DEMO
 */

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(130,130);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[RGCollectionViewCell class] forCellWithReuseIdentifier:CELL_REUSE];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.3 green:0.22 blue:0.29 alpha:1];
    [self.view addSubview:self.collectionView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



- (UIImageView *)sourceImageView
{
    RGCollectionViewCell *cell = (RGCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    return cell.cellImageView;
}

- (void)finsihedSeeing:(BOOL)value
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    RGCollectionViewCell *castedCell = (RGCollectionViewCell *) [self.collectionView dequeueReusableCellWithReuseIdentifier:CELL_REUSE
                                                                                                               forIndexPath:indexPath];
    NSString *imageName = self.imageNameList[indexPath.row];
    castedCell.cellImageView.image = [UIImage imageNamed:imageName];
    return castedCell;
}


#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
    self.imagePickerController.isPresenting = YES;
    [self presentViewController:self.imagePickerController
                       animated:YES
                     completion:^{
    }];
}

#pragma mark - Lazy Loading

- (RGImageViewController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[RGImageViewController alloc] init];
        _imagePickerController.transitioningDelegate = _imagePickerController;
        _imagePickerController.isPresenting = YES;
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}

@end
