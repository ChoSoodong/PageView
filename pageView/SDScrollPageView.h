






#import <UIKit/UIKit.h>
#import "SDScrollPageTitleView.h"
#import "SDSrollPageTitleConfig.h"
#import "SDPageContentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SDScrollPageView : UIView

/** 标题数组 */
@property (nonatomic, strong) NSArray<NSString *> *titlesArray;
/** 子控制器数组 */
@property (nonatomic, strong) NSArray<UIViewController *> *childControllers;
/** 父控制器 */
@property (nonatomic, strong) UIViewController *parentController;


/** titleView */
@property (nonatomic, strong) SDScrollPageTitleView *titleView;
/** 标题配置 */
@property (nonatomic, strong) SDSrollPageTitleConfig *titleConfig;
/** 容器 */
@property (nonatomic, strong) SDPageContentView *contentView;


/**
 初始化方法

 @param frame frame
 @param titles 标题数组
 @param childControllers 子控制器数组
 @param parentController 父控制器
 @param titleConfig 标题属性的配置
 @return pageView
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childControllers:(NSArray<UIViewController *> *)childControllers parentController:(UIViewController *)parentController titleConfig:(SDSrollPageTitleConfig *)titleConfig;


//销毁
-(void)destory;
@end

NS_ASSUME_NONNULL_END
