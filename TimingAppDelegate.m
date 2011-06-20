//
//  TimingAppDelegate.m
//  Timing
//
//  Created by 菊川 真理子 on 11/06/17.
//  Copyright 2011 北陸先端科学技術大学院大学. All rights reserved.
//

#import "TimingAppDelegate.h"

#define GAUSE 0
#define ZOOMEIN 1
#define DIALOG 2

@implementation TimingAppDelegate

//@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	_mode = DIALOG;
	_preIntDis = 0;
	// Insert code here to initialize your application 
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
													 target:self
												   selector:@selector(observeActivate:)
												   userInfo:nil
													repeats:YES];
}

-(void)observeActivate:(NSTimer*)timer{
	NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
	NSDictionary *actApp = [workspace activeApplication];
	NSNumber *appNum = [actApp valueForKey:@"NSApplicationProcessIdentifier"];
	if (_preActNum != appNum) {
		NSString* path = @"/Users/kikugawamariko/logs/distanceLog.txt";
		NSError* error;
		NSString* argDis = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
		NSArray *arrDis = [argDis componentsSeparatedByString:@"\n"];
		int cntDis = [arrDis count];
		NSString *lastDis = [arrDis objectAtIndex:cntDis-2];
		int intDis = [lastDis intValue];
		char exeSeg[255];
		int i;
		if( _mode == GAUSE){
			sprintf(exeSeg,"osascript ../../app_and_scripts/changeSpot.scpt %d",intDis);
			system(exeSeg);
		}else if(_mode == ZOOMEIN){
			if(_preIntDis > intDis){
				sprintf(exeSeg,"osascript ../../app_and_scripts/kaizoudo_down.scpt");
				for( i=0; i<_preIntDis-intDis; i++){
					system(exeSeg);					
				}
			}
			if(_preIntDis < intDis){
				sprintf(exeSeg,"osascript ../../app_and_scripts/kaizoudo_up.scpt");
				for( i=0; i<intDis-_preIntDis; i++){
					system(exeSeg);					
				}
			}
			_preIntDis = intDis;
		}else if (_mode == DIALOG) {
			if (intDis > 0) {
				sprintf(exeSeg,"osascript ../../app_and_scripts/faceDialog.scpt");
				system(exeSeg);	
			}
		}
	}
	_preActNum = appNum;
}


@end
