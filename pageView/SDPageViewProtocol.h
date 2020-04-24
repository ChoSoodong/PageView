




//////////  标题点击 代理
@class SDScrollPageTitleView,SDPageContentView;

@protocol SDScrollPageTitleViewDelegate<NSObject>

-(void)titleViewClickTitle:(SDScrollPageTitleView *)titleView targetIndex:(NSInteger)targetIndex;

@end


/////////// 容器滚动 代理
@protocol SDPageContentViewDelegate<NSObject>

-(void)contentViewScroll:(SDPageContentView *)contentView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

-(void)contentViewScroll:(SDPageContentView *)contentView targetIndex:(NSInteger)targetIndex;

@end
