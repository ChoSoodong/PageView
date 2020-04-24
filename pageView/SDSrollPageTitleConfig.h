


/////// 标题配置文件

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDSrollPageTitleConfig : NSObject

/** 标题view的高度 */
@property (nonatomic, assign) CGFloat titleHeight; // 默认44.0f
/** 普通状态下颜色 */
@property (nonatomic, strong) UIColor *normalColor; //默认 0x757575
/** 选中状态下颜色 */
@property (nonatomic, strong) UIColor *selectedColor;//默认 0x1A85D7
/** 字体大小 */
@property (nonatomic, assign) CGFloat fontSize; //默认14.0f
/** 是否启用滚动 */
@property (nonatomic, assign) BOOL isScrollEnable; //默认是yes
/** 标题item间距 */
@property (nonatomic, assign) CGFloat itemMargin; //默认25.0
/** 索引 */
@property (nonatomic, assign) NSInteger targetIndex; //默认0
/** 是否显示底部线 */
@property (nonatomic, assign) BOOL isShowBottomLine; //默认yes
/** 线的高度 */
@property (nonatomic, assign) CGFloat bottomLineHeight; //默认2.0f
/** 线的颜色 */
@property (nonatomic, strong) UIColor *bottomLineColor; //默认orange

@end

NS_ASSUME_NONNULL_END
