//
//  CardInst.m
//  Virtual Phylo
//
//  Created by Suban K on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CardInst.h"

@implementation CardInst

// Changes the size of the CardInst
- (void)changeWidth:(int)width andHeight:(int)height{
    
}

// Changes the (x,y) position
- (void)setX:(int)x andY:(int)y{
    
}

/*
 //
 //  ViewController.m
 //  Tutorial
 //
 //  Created by Roger Zhao on 2013-06-10.
 //  Copyright (c) 2013 Roger Zhao. All rights reserved.
 //
 
 #import "ViewController.h"
 #import "CardCell.h"
 
 @interface ViewController () {
 NSArray *cardImages;
 }
 
 @end
 
 @implementation ViewController
 
 // Implement property
 @synthesize movableCardView;
 @synthesize movableCardView1;
 @synthesize movableCardView2;
 @synthesize movableCardView3;
 @synthesize movableCardView4;
 @synthesize movableCardView5;
 
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 
 [[self cardCollectionView]setDataSource:self];
 [[self cardCollectionView]setDelegate:self];
 
 movableCardView.backgroundColor = [UIColor clearColor];
 movableCardView1.backgroundColor = [UIColor redColor];
 movableCardView2.backgroundColor = [UIColor greenColor];
 movableCardView3.backgroundColor = [UIColor blueColor];
 movableCardView4.backgroundColor = [UIColor whiteColor];
 movableCardView5.backgroundColor = [UIColor blackColor];
 UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
 UIPanGestureRecognizer *panGesture1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
 UIPanGestureRecognizer *panGesture2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
 UIPanGestureRecognizer *panGesture3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
 UIPanGestureRecognizer *panGesture4 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
 UIPanGestureRecognizer *panGesture5 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
 
 [movableCardView addGestureRecognizer:panGesture];
 [movableCardView1 addGestureRecognizer:panGesture1];
 [movableCardView2 addGestureRecognizer:panGesture2];
 [movableCardView3 addGestureRecognizer:panGesture3];
 [movableCardView4 addGestureRecognizer:panGesture4];
 [movableCardView5 addGestureRecognizer:panGesture5];
 
 cardImages = [NSArray arrayWithObjects: @"0.png", @"1.png", @"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png",@"10.png",@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png",@"17.png",@"18.png",@"19.png",@"20.png",@"21.png",@"22.png",@"23.png",@"24.png",@"25.png",@"26.png",@"27.png",@"28.png",@"29.png",@"30.png",@"31.png",@"32.png",@"33.png",@"34.png",@"35.png",@"36.png",@"37.png",@"38.png",@"39.png",@"40.png",@"home_Card.png", nil];
 }
 
 // datasource and delegate
 -(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 return 1;
 }
 
 -(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return [cardImages count];
 }
 
 -(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"Card";
 CardCell *card = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
 [[card cardImage]setImage: [UIImage imageNamed:[cardImages objectAtIndex: indexPath.item]]];
 
 return card;
 }
 
 // Move card objects
 - (void)handlePan:(UIPanGestureRecognizer*) recognizer {
 
 CGPoint translation = [recognizer translationInView:recognizer.view];
 
 recognizer.view.center=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
 
 [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
 
 }
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 @end
 
*/

@end
