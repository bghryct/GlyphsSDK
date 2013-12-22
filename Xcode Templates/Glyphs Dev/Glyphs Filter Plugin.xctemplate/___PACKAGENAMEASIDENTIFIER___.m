//
//  ___FILENAME___
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"

@implementation ___FILEBASENAMEASIDENTIFIER___

- (id)init {
	self = [super init];
	[NSBundle loadNibNamed:@"___FILEBASENAMEASIDENTIFIER___Dialog" owner:self];
	return self;
}

- (NSUInteger) interfaceVersion {
	// to distinguish the API verison the plugin was build for. Return 1.
	return 1;
}
- (NSString *) title {
	//return the name of the tool as it will appear in the menu.
	return @"___PACKAGENAME___";
}
- (NSString*) actionName {
	//The title of the button in the filter dialog.
	return @"___PACKAGENAME___";
}

- (NSString*) keyEquivalent {
	// the key together with cmp + shift will be the shortcut for the filter.
	return nil;
}
- (void) processFont:(GSFont*)Font withArguments: (NSArray*) Arguments {
	// The Arguments come from the custom parameter in the instance settings. 
	// The first item in Arguments is the class-name, after that it depends on the filter.
	CGFloat FirstValue;
	if ([Arguments count] > 1) {
		_firstValue = [[Arguments objectAtIndex:1] floatValue];
	}
	checkSelection = NO;
	NSString * FontMasterId = [Font fontMasterAtIndex:0].id;
	for (GSGlyph * Glyph in Font.glyphs) {
		GSLayer * Layer = [Glyph layerForKey:FontMasterId];
		[self processLayer:Layer ];
	}
}
- (void) setFirstValue:(id) sender {
	// This is ony an example for a setter method. You would need to add methods like this for each option in the dialog
	CGFloat FirstValue = [sender floatValue];
	if(fabs(FirstValue - _firstValue) > 0.01) {
		_firstValue = FirstValue;
		[self process:nil];
	}
}
- (void) process:(id) sender {
	int k;
	for (k = 0; k < [_shadowLayers count]; k++) {
		GSLayer * ShadowLayer = [_shadowLayers objectAtIndex:k];
		GSLayer * Layer = [_layers objectAtIndex:k];
		Layer.paths = [[NSMutableArray alloc] initWithArray:ShadowLayer.paths copyItems:YES];
		Layer.selection = [NSMutableArray array];
		if ([ShadowLayer.selection count] > 0 && checkSelection) {
			int i, j;
			for (i = 0; i < [ShadowLayer.paths count]; i++ ) {
				GSPath * currShadowPath = [ShadowLayer.paths objectAtIndex:i];
				GSPath * currLayerPath = [Layer.paths objectAtIndex:i];
				for (j = 0; j < [currShadowPath.nodes count]; j++) {
					GSNode * currShadowNode = [currShadowPath.nodes objectAtIndex:j];
					if ([ShadowLayer.selection containsObject:currShadowNode]) {
						[Layer addSelection:[currLayerPath.nodes objectAtIndex:j]];
					}
				}
			}
		}
		[self processLayer:Layer];
		[Layer clearSelection];
	}
	[_fontMaster.userData setObject:[NSNumber numberWithDouble:_radius] forKey:@"GSCornerRadius"];
	[super process:nil];
}

@end