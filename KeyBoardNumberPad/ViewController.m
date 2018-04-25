//
//  ViewController.m
//  KeyBoardNumberPad
//
//  Created by MM on 2018/4/25.
//  Copyright © 2018年 MM. All rights reserved.
//

#import "ViewController.h"

#define ViewHight               ([[UIScreen mainScreen] bounds].size.height)
#define ViewWidth                ([[UIScreen mainScreen] bounds].size.width)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong) UIButton *searchButton;//自定义搜索按钮
@end

@implementation ViewController
- (UIButton *)searchButton
{
    if (!_searchButton) {
        CGFloat btnH = 0;
        if (ViewWidth == 320 || ViewWidth == 375) {
            btnH = 160;
        }else if (ViewWidth == 414){
            btnH = 169;
        }
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(0, 163, 106, 53);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _searchButton.frame = CGRectMake(0, ViewHight,ViewWidth/3-2 , btnH / 3);
        [_searchButton addTarget:self action:@selector(searchUser) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)searchUser
{
    [self.searchBar resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
#pragma mark -
// 结束编辑时会来到该方法
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self searchUser];
}
// 开始编辑时会来到该方法(可以在该方法判断是否允许用户输入)
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
// 结束编辑时会来到该方法
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}
#pragma mark - 键盘
- (void)handleKeyboardWillShow:(NSNotification *)notification
{
    NSUInteger  cnt = [[UIApplication  sharedApplication ]  windows ].count;
    // 获得UIWindow 层
    UIWindow  * keyboardWindow = [[[UIApplication  sharedApplication ]  windows ]  objectAtIndex:cnt - 1];
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.searchButton.frame = CGRectMake(0, ViewHight + kbSize.height, self.searchButton.frame.size.width , self.searchButton.frame.size.height);
    
    [keyboardWindow addSubview:self.searchButton];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.searchButton.frame= CGRectMake(0, ViewHight - self.searchButton.frame.size.height, self.searchButton.frame.size.width , self.searchButton.frame.size.height);
    }];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        self.searchButton.frame= CGRectMake(0, ViewHight, self.searchButton.frame.size.width , self.searchButton.frame.size.height);
    }];
}



@end
