//
//  Edit in TextMate.h
//
//  Created by Allan Odgaard on 2005-11-26.
//  See /trunk/LICENSE for license details
//

#import <Cocoa/Cocoa.h>

bool debug_enabled ();

#define D(format, args...) if(debug_enabled()) NSLog(format, ##args);

@interface EditInTextMate : NSObject
{
}
+ (void)externalEditString:(NSString*)aString startingAtLine:(int)aLine forView:(NSView*)aView;
+ (void)externalEditString:(NSString*)aString startingAtLine:(int)aLine forView:(NSView*)aView withObject:(NSObject*)anObject;
@end
