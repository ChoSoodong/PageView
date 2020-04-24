



///////// 容器view

#import <UIKit/UIKit.h>
#import "SDPageViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface SDPageContentView : UIView<SDScrollPageTitleViewDelegate>


/**
 初始化方法

 @param frame frame
 @param childControllers 子控制器数组
 @param parentController 父控制器
 @return contentView
 */
-(instancetype)initWithFrame:(CGRect)frame childControllers:(NSArray<UIViewController *> *)childControllers parentController:(UIViewController *)parentController;

//标题点击的代理方法
-(void)titleViewClickTitle:(SDScrollPageTitleView *)titleView targetIndex:(NSInteger)targetIndex;

/** 代理属性 */
@property (nonatomic, weak) id<SDPageContentViewDelegate> delegate;




@end

NS_ASSUME_NONNULL_END
