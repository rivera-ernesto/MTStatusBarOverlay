//
//  ViewController.m
//  Demo
//
//  Created by 利辺羅 on 2013/05/24.
//
//

#import "ViewController.h"
#import "MTStatusBarOverlay.h"

@implementation ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MTStatusBarOverlay * overlay = [MTStatusBarOverlay sharedInstance];
    overlay.animation = MTStatusBarOverlayAnimationFallDown;  // MTStatusBarOverlayAnimationShrink
    overlay.detailViewMode = MTDetailViewModeHistory;         // enable automatic history-tracking and show in detail-view
    
    NSArray * messages = @[@"Following @myell0w on Twitter…",
                           @"Following myell0w on Github…",
                           @"Following was a good idea!"];
    
    for (NSUInteger i = 0; i < messages.count; i++)
    {
        NSString * message = messages[i];
        
        double delayInSeconds = 1.0 + i * 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                       {
                           overlay.progress = (CGFloat)i / (CGFloat)(messages.count - 1);
                           
                           if (overlay.progress < 1.0)
                           {
                               [overlay postMessage:message
                                           animated:YES];
                           }
                           else
                           {
                               [overlay postFinishMessage:message
                                                 duration:2.0
                                                 animated:YES];
                           }
                       });
    }
}

- (IBAction)postMessage:(id)sender
{
    MTStatusBarOverlay * overlay = [MTStatusBarOverlay sharedInstance];
    [overlay postMessage:[NSString stringWithFormat:@"Message at %@", [NSDate date]]
                duration:2.0
                animated:YES];
}

- (IBAction)postImmediateMessage:(id)sender
{
    MTStatusBarOverlay * overlay = [MTStatusBarOverlay sharedInstance];
    [overlay postImmediateMessage:[NSString stringWithFormat:@"Message at %@", [NSDate date]]
                         duration:2.0
                         animated:YES];
}

- (IBAction)postFinishMessage:(id)sender
{
    MTStatusBarOverlay * overlay = [MTStatusBarOverlay sharedInstance];
    [overlay postFinishMessage:[NSString stringWithFormat:@"Message at %@", [NSDate date]]
                      duration:2.0
                      animated:YES];
}

- (IBAction)postErrorMessage:(id)sender
{
    MTStatusBarOverlay * overlay = [MTStatusBarOverlay sharedInstance];
    [overlay postErrorMessage:[NSString stringWithFormat:@"Message at %@", [NSDate date]]
                     duration:2.0
                     animated:YES];
}

@end
