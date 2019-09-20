//
//  DockController.h
//  SinnaWeiBoDemo
//


#import <UIKit/UIKit.h>
#import "Dock.h"
@interface DockController : UIViewController
{
    Dock *_dock;
}
@property (nonatomic, readonly) UIViewController *selectedController;

@end
