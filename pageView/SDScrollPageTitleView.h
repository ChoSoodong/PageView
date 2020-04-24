


/////////  标题View

#import <UIKit/UIKit.h>
#import "SDPageContentView.h"
#import "SDSrollPageTitleConfig.h"
#import "SDPageViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN


@interface SDScrollPageTitleView : UIView<SDPageContentViewDelegate>


/**
 初始化方法

 @param frame frame
 @param titles 标题数组
 @param config 标题属性配置
 @return titleView
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles config:(SDSrollPageTitleConfig *)config;


/** 代理属性 */
@property (nonatomic, weak) id<SDScrollPageTitleViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
