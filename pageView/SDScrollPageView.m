




#import "SDScrollPageView.h"

@interface SDScrollPageView()

@end

@implementation SDScrollPageView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childControllers:(NSArray<UIViewController *> *)childControllers parentController:(UIViewController *)parentController titleConfig:(SDSrollPageTitleConfig *)titleConfig{
    if (self = [super initWithFrame:frame]) {
        
        self.titlesArray = titles;
        self.childControllers = childControllers;
        self.parentController = parentController;
        self.titleConfig = titleConfig;
        
        [self setupUI];
    }
    return self;
}

#pragma mark - 初始化UI
-(void)setupUI{
    
    //添加标题view
    [self setTileView];
    
    //添加容器view
    [self setContentView];
    
    //设置代理
    self.titleView.delegate = self.contentView;
    self.contentView.delegate = self.titleView;
    
}

#pragma mark - 添加标题view
-(void)setTileView{
    
    CGRect titleFrame = CGRectMake(0, 0, self.bounds.size.width, self.titleConfig.titleHeight);
    self.titleView = [[SDScrollPageTitleView alloc] initWithFrame:titleFrame titles:self.titlesArray config:self.titleConfig];
    [self addSubview:self.titleView];
   
}

#pragma mark - 添加容器view
-(void)setContentView{
 
    CGRect contentFrame = CGRectMake(0, self.titleConfig.titleHeight, self.bounds.size.width, self.bounds.size.height - self.titleConfig.titleHeight);
    self.contentView = [[SDPageContentView alloc] initWithFrame:contentFrame childControllers:self.childControllers parentController:self.parentController];
    [self addSubview:self.contentView];
    
    //调用一次标题点击代理方法
    [self.contentView titleViewClickTitle:self.titleView targetIndex:self.titleConfig.targetIndex];
}


#pragma mark - 销毁通知
- (void)dealloc {
    NSLog(@"pageView 销毁了");
}

#pragma mark - 销毁
-(void)destory{
    
    for (UIViewController *vc in self.childControllers) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    [self.titleView removeFromSuperview];
    [self.contentView removeFromSuperview];
    [self removeFromSuperview];
}

@end
