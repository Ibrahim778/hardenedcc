
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <SpringBoard/SBLockStateAggregator.h>
#import <RemoteLog.h>

@interface UIView (HardenedCC)

@property (assign,setter=_setViewDelegate:,getter=_viewDelegate,nonatomic) UIViewController * viewDelegate;

@end