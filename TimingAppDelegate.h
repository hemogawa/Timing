//
//  TimingAppDelegate.h
//  Timing
//
//  Created by 菊川 真理子 on 11/06/17.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TimingAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSNumber *_preActNum;
	int _preIntDis;
	int _mode;
}
//@property (assign) IBOutlet NSWindow *window;
-(void)observeActivate:(NSTimer*)timer;

@end
