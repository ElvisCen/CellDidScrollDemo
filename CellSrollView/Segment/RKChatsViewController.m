//
//  RKChatsViewController.m
//  自定义导航条
//
//  Created by ElvisCen on 2017/3/16.
//  Copyright © 2017年 ElvisCen. All rights reserved.
//

#import "RKChatsViewController.h"
#import "JDragonTypeButtonView.h"
@interface RKChatsViewController ()<JDragonTypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    JDragonTypeButtonView *buttonView;
}
@end

@implementation RKChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    self.view.backgroundColor =[UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *titleArr =@[@"第0行",@"第1行",@"第2行"];
    buttonView =[[JDragonTypeButtonView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 64)];
    [buttonView setTypeButtonTitles:titleArr withDownLableHeight:64 andDeleagte:self];
    [buttonView setTypeDownlableSelectColor:[UIColor clearColor]];
    buttonView.backgroundColor =[UIColor lightGrayColor];
    return buttonView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return [[UIScreen mainScreen]bounds].size.height-400-128;
    }
    
    return 400;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}


#pragma mark - UIScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
    NSLog(@"yOffset:%f",scrollView.contentOffset.y);
    CGFloat xOffset = scrollView.contentOffset.x;
    CGFloat yOffset = scrollView.contentOffset.y +128;//由于cell的其实位置是在headerview之后所以，下移相应的高度，这里导航烂的高度与headerview的高度和为128
    //计算相应行
    NSIndexPath *path = [_tableView indexPathForRowAtPoint:CGPointMake(xOffset, yOffset)];
    NSLog(@"第%zd行",path.row);
    //设置buttonView变化
    [UIView animateWithDuration:0.25 animations:^{
        [buttonView setSelectButtonIndex:path.row];
    }];
    
    
}


#pragma mark - JDragonTypeButtonActionDelegate
-(void)didClickTypeButtonAction:(UIButton*)button withIndex:(NSInteger)index{
    NSLog(@"%zd",index);
    
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
   
}
@end
