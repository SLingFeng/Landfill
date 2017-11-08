//
//  LYWebViewController.m
//  LYWebViewController
//
//  Created by LvYuan on 16/7/9.
//  Copyright © 2016年 LvYuan. All rights reserved.
//

#import "LYWebViewController.h"

@import WebKit;

#define kWebViewEstimatedProgress @"estimatedProgress"
#define kBackImageName @"backItemImage"
#define kBackImageNameHL @"backItemImageHL"
#define kNavHeight 64.f
#define kItemSize 44.f
#define kBackWidth 46.f
#define kProgressDefaultTintColor [UIColor greenColor]

//扩展
@interface NSArray (Extension)

- (BOOL)exsit:(id)obj;

@end

@implementation NSArray (Extension)

- (BOOL)exsit:(id)object{
    
    for (id obj in self) {
        if (obj == object) {
            return true;
        }
    }
    return false;
}
@end



@interface LYWebViewController()<WKNavigationDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIBarButtonItem * backItem;

@property(nonatomic,strong)UIBarButtonItem * closeItem;

@property(nonatomic,strong)NSMutableArray * leftItems;

@property(nonatomic,strong)WKWebView * webView;

@property(nonatomic,strong)UIProgressView * progressView;

@end

@implementation LYWebViewController

//释放监听
- (void)dealloc{
    [_webView removeObserver:self forKeyPath:kWebViewEstimatedProgress];
}

//懒加载
- (WKWebView *)webView{
    if (!_webView) {
        
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        self.view = _webView;
        //打开右滑回退功能
        _webView.allowsBackForwardNavigationGestures = true;
        //有关导航事件的委托代理
        _webView.navigationDelegate = self;
        
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.frame = CGRectMake(0, kNavHeight - _progressView.frame.size.height, self.view.bounds.size.width, _progressView.frame.size.height);
        _progressView.tintColor = self.progressTintColor;
        [self.navigationController.view addSubview:_progressView];

    }
    return _progressView;
}

- (UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        
        UIButton * close = [UIButton buttonWithType:UIButtonTypeSystem];
        [close setTitle:@"关闭" forState:UIControlStateNormal];
        close.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        close.frame = CGRectMake(0, 0, kItemSize, kItemSize);
        close.tintColor = self.navigationController.navigationBar.tintColor;
        [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        //close.backgroundColor = [UIColor lightGrayColor];
         _closeItem = [[UIBarButtonItem alloc]initWithCustomView:close];
        
    }
    return _closeItem;
}

- (UIColor *)progressTintColor{
    if (!_progressTintColor) {
        
        _progressTintColor = kProgressDefaultTintColor;
        
    }
    return _progressTintColor;
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        
        UIButton * back = [UIButton buttonWithType:UIButtonTypeSystem];
        [back setImage:[UIImage imageNamed:kBackImageName] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:kBackImageNameHL] forState:UIControlStateHighlighted];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        back.frame = CGRectMake(0, 0, kBackWidth, kItemSize);
        back.tintColor = self.navigationController.navigationBar.tintColor;
        [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        //back.backgroundColor = [UIColor lightGrayColor];
        _backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
        
    }
    return _backItem;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    //加载请求
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    //监听estimatedProgress
    [_webView addObserver:self forKeyPath:kWebViewEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    
    //隐藏progressView
    self.progressView.hidden = true;
    
    //左items
    self.leftItems = [NSMutableArray arrayWithObject:self.backItem];
    
    self.closeItem.tintColor = self.navigationController.navigationBar.tintColor;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = !_webView.canGoBack;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_progressView removeFromSuperview];
    _progressView = nil;
    _closeItem = nil;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)setLeftItems:(NSMutableArray *)leftItems{
    _leftItems = leftItems;
    //显示左按钮
    [self setLeftItems];
}

- (void)setLeftItems{
    self.navigationItem.leftBarButtonItems = _leftItems;
}

- (void)showCloseItem{
    NSLog(@"Show");
    if (![_leftItems exsit:_closeItem]) {
        [self.leftItems addObject:_closeItem];
    }
    [self setLeftItems];
}
- (void)hiddenCloseItem{
    NSLog(@"Hidden");
    if ([_leftItems exsit:_closeItem]) {
        [self.leftItems removeObject:_closeItem];
    }
    [self setLeftItems];
}

#pragma mark - 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    _progressView.progress = _webView.estimatedProgress;
}

#pragma mark - actions

- (void)close:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)back:(UIBarButtonItem *)sender{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self close:nil];
    }
}

#pragma mark - navigation delegate

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progressView.hidden = false;
}

//内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
- (void)popGestureRecognizerEnable{

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        if ([self.navigationController.viewControllers count] == 2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
        
    }
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    _progressView.hidden = true;
    self.title = _webView.title;
    
    if (!_webView.canGoBack) {
        [self popGestureRecognizerEnable];
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = !_webView.canGoBack;
    
    if (_webView.canGoForward) {
        [self showCloseItem];
    }else{
        [self hiddenCloseItem];
    }
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    _progressView.hidden = true;
    
}

@end


