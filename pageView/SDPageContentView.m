





#import "SDPageContentView.h"
#import "SDScrollPageTitleView.h"

@interface SDPageContentView()<UIScrollViewDelegate>

/** 父控制器 */
@property (nonatomic, strong) UIViewController *parentController;
/** 子控制器数组 */
@property (nonatomic, strong) NSArray<UIViewController *> *childControllers;
/** 开始平移量 */
@property (nonatomic, assign) CGFloat beginDraggingOffsetX;
/** 是否禁止滚动 */
@property (nonatomic, assign) BOOL isForbidScroll;
/** 选中的索引 */
@property (nonatomic, assign) NSInteger selectedIndex;

/** 容器 */
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation SDPageContentView

-(instancetype)initWithFrame:(CGRect)frame childControllers:(NSArray<UIViewController *> *)childControllers parentController:(UIViewController *)parentController{
    if (self = [super initWithFrame:frame]) {
        
        self.childControllers = childControllers;
        self.parentController = parentController;
        
        [self setupUI];
        
    }
    return self;
}

-(void)setupUI{
    
    if (self.childControllers.count == 0 || self.parentController == nil) {
        return;
    }
    
     //添加childController
    for (UIViewController *childVC in self.childControllers) {
        [self.parentController addChildViewController:childVC];
    }
    
     //添加容器View
    [self addSubview:self.contentView];
    
     //添加第一个childController的view
    UIViewController *firstChildVC = self.childControllers.firstObject;
    firstChildVC.view.frame = self.contentView.bounds;
    [self.contentView addSubview:firstChildVC.view];

    
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UIButton class]]) {
        return view;
    }else if(self.selectedIndex == 0 && point.x < 80){
        return nil; //可以滑动返回
    }else if(self.selectedIndex == 0 && point.x < 80){
        return nil; //可以滑动返回
    }else{
        return view;
    }
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.isForbidScroll = NO;
    
    self.beginDraggingOffsetX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self endScroll:scrollView];
    }else{
        scrollView.scrollEnabled = NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 0.判断和开始时的偏移量是否一致
    if (self.beginDraggingOffsetX == scrollView.contentOffset.x && self.isForbidScroll) {
        return;
    }
    
    // 1.定义targetIndex/progress
    NSInteger targetIndex = 0;
    CGFloat progress = 0.0;

    // 2.给targetIndex/progress赋值
    NSInteger currentIndex = (NSInteger)(self.beginDraggingOffsetX / scrollView.bounds.size.width);
    if (self.beginDraggingOffsetX < scrollView.contentOffset.x) { // 左滑动
        targetIndex = currentIndex + 1;
        progress = (scrollView.contentOffset.x - self.beginDraggingOffsetX) / scrollView.bounds.size.width;
    }else{ // 右滑动
        targetIndex = currentIndex - 1;
        progress = (self.beginDraggingOffsetX - scrollView.contentOffset.x) / scrollView.bounds.size.width;
    }
    
    //3.判断是否越界
    if (targetIndex < 0 || targetIndex > _childControllers.count - 1) {
        targetIndex = currentIndex;
    }
    
    if ([self.delegate respondsToSelector:@selector(contentViewScroll:targetIndex:progress:)]) {
        [self.delegate contentViewScroll:self targetIndex:targetIndex progress:progress];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self endScroll:scrollView];
    scrollView.scrollEnabled = YES;
}


-(void)endScroll:(UIScrollView *)scrollView{
    
    NSInteger targetIndex = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
    [self addChildControllerView:scrollView targetIndex:targetIndex];
   
    if ([self.delegate respondsToSelector:@selector(contentViewScroll:targetIndex:)]) {
        [self.delegate contentViewScroll:self targetIndex:targetIndex];
    }
    self.selectedIndex = targetIndex;
}

-(void)addChildControllerView:(UIScrollView *)scrollView targetIndex:(NSInteger)targetIndex{
    
    if (targetIndex >= self.childControllers.count) {
        return;
    }
    
    UIViewController *childVC = self.childControllers[targetIndex];
    //subview是否是superView的子视图
    if (![childVC.view isDescendantOfView:scrollView]) {
        childVC.view.frame = CGRectMake(scrollView.bounds.size.width*(CGFloat)targetIndex, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        [scrollView addSubview:childVC.view];
    }
    
}

-(UIScrollView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.delegate = self;
        _contentView.bounces = NO;
        _contentView.pagingEnabled = YES;
        _contentView.scrollsToTop = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.contentSize = CGSizeMake(self.bounds.size.width*self.childControllers.count, self.bounds.size.height);
    }
    return _contentView;
}

#pragma mark - 标题点击代理方法
-(void)titleViewClickTitle:(SDScrollPageTitleView *)titleView targetIndex:(NSInteger)targetIndex{
    
    self.selectedIndex = targetIndex;
    self.isForbidScroll = YES;
    
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat x = self.contentView.bounds.size.width * (CGFloat)(targetIndex);
    CGRect rect = CGRectMake(x, 0, width, self.contentView.frame.size.height);
    
    [self.contentView scrollRectToVisible:rect animated:NO];
    [self addChildControllerView:self.contentView targetIndex:targetIndex];
}

@end
