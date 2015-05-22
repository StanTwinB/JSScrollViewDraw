//
//  JSDViewController.m
//  JSDraw
//
//  Created by McLaren Stanley on 3/14/13.
//  Copyright (c) 2013 McLaren Stanley. All rights reserved.
//

#import "JSDViewController.h"

@interface JSDViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIScrollView *drawLoopScrollView;
@end

@implementation JSDViewController

- (UIScrollView *)drawLoopScrollView
{
    if (!_drawLoopScrollView)
    {
        _drawLoopScrollView = [[UIScrollView alloc] init];
        _drawLoopScrollView.delegate = self;
    }
    return _drawLoopScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.drawLoopScrollView.panGestureRecognizer];
    [self.drawLoopScrollView setContentSize:CGSizeMake(10024, 10548)];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"DrawProp" withExtension:@"html"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat contentWidth = [[self.webView stringByEvaluatingJavaScriptFromString:@"loopLength()"] floatValue];
    self.drawLoopScrollView.contentSize = CGSizeMake(CGRectGetHeight(self.view.frame), contentWidth);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  //  NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"drawLoop(%.2f)", scrollView.contentOffset.y]];
}

- (IBAction)propellerPressed:(UIButton *)sender
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"DrawProp" withExtension:@"html"];
    self.drawLoopScrollView.contentOffset = CGPointMake(0, 0);
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (IBAction)textPressed:(UIButton *)sender
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"DrawScroll" withExtension:@"html"];
    self.drawLoopScrollView.contentOffset = CGPointMake(0, 0);
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
@end
