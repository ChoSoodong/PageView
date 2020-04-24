





#import "SDScrollPageTitleView.h"


@interface SDScrollPageTitleView()

/** 标题 */
@property (nonatomic, strong) NSArray<NSString *> *titles;
/** 配置 */
@property (nonatomic, strong) SDSrollPageTitleConfig *titleConfig;

/** label 数组 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *titleLabels;
/** 滚动view */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 底部线 */
@property (nonatomic, strong) UIView *bottomLine;


@end

@implementation SDScrollPageTitleView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles config:(SDSrollPageTitleConfig *)config{
    if (self = [super initWithFrame:frame]) {
        
        self.titles = titles;
        self.titleConfig = config;
        [self setupUI];
        
    }
    return self;
}

#pragma mark - 初始化UI
-(void)setupUI{
    //1.将scrollview添加到view
    [self addSubview:self.scrollView];
    
    //2.将titleLabel添加到scrollview上
    [self setTitleLabels];

    //3.设置titleLabel的frame
    [self setTitlabelFrame];
    
    //4.设置底部下划线
    if (self.titleConfig.isShowBottomLine) {
        [self.scrollView addSubview:self.bottomLine];
    }
}

#pragma mark - 添加label
-(void)setTitleLabels{
    
    [self.titleLabels removeAllObjects];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.titles[i];
        label.font = [UIFont systemFontOfSize:self.titleConfig.fontSize];
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.textColor = self.titleConfig.targetIndex == i ? self.titleConfig.selectedColor : self.titleConfig.normalColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitleLabel:)];
        [label addGestureRecognizer:tap];
        [label sizeToFit];
        [self.scrollView addSubview:label];
        [self.titleLabels addObject:label];
    }

}

#pragma mark - 设置frame
-(void)setTitlabelFrame{
    
    NSInteger count = self.titleLabels.count;
    
    for (NSInteger i = 0; i < self.titleLabels.count ; i++) {
        CGFloat w = 0;
        CGFloat h = self.bounds.size.height;
        CGFloat x = 0;
        CGFloat y = 0;
        UILabel *titleLabel = self.titleLabels[i];
        
        if (self.titleConfig.isScrollEnable) {
             //可以滚动
            w = titleLabel.bounds.size.width;
            if (i == 0) {
                x = self.titleConfig.itemMargin*0.5;
            }else{
                UILabel *preLabel = self.titleLabels[i - 1];
                x = CGRectGetMaxX(preLabel.frame) + self.titleConfig.itemMargin;
            }
  
        }else{
            //不能滚动
            w = self.bounds.size.width / (CGFloat)count;
            x = w * (CGFloat)i;
        }
        
        titleLabel.frame = CGRectMake(x, y, w, h);
        
        if (i == self.titleConfig.targetIndex && self.titleConfig.isShowBottomLine) {
            self.bottomLine.frame = CGRectMake(x,self.bottomLine.origin.y , w, self.bottomLine.size.height);
        }

    }
    
    if (self.titleConfig.isScrollEnable) {
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.titleLabels.lastObject.frame)+self.titleConfig.itemMargin*0.5,self.scrollView.height);
    }else{
        self.scrollView.contentSize = CGSizeZero;
    }
    
}

#pragma mark - label 点击方法
-(void)clickTitleLabel:(UITapGestureRecognizer *)tapGes{
    
    //1.取出label
    UILabel *targetLabel = (UILabel *)tapGes.view;
    
    //2.调整titleLabel位置
    [self adjustTitleLabelWithTargetIndex:targetLabel.tag];
   
    // 3.调整bottomLine
    if (self.titleConfig.isShowBottomLine) {
        NSLog(@"%lf",targetLabel.frame.origin.x);
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.frame = CGRectMake(targetLabel.frame.origin.x, self.bottomLine.origin.y, targetLabel.size.width, self.bottomLine.size.height);
        }];
    }
    
    //3.通知contentView调整
    if ([self.delegate respondsToSelector:@selector(titleViewClickTitle:targetIndex:)]) {
        [self.delegate titleViewClickTitle:self targetIndex:self.titleConfig.targetIndex];
    }
    

}

#pragma mark - 调整选中label
-(void)adjustTitleLabelWithTargetIndex:(NSInteger)targetIndex{
    
    //0.判断是在滑动的时候是否取消
    if (targetIndex == self.titleConfig.targetIndex) {
        return;
    }
    
    //1.取出label
    UILabel *didSelectLabel = self.titleLabels[self.titleConfig.targetIndex];
    UILabel *willSelecteLabel = self.titleLabels[targetIndex];
    
    //2.切换颜色
    didSelectLabel.textColor = self.titleConfig.normalColor;
    willSelecteLabel.textColor = self.titleConfig.selectedColor;
    
    //3. 记录选中的下标
    self.titleConfig.targetIndex = willSelecteLabel.tag;
    
    //4.调整滚动位置
    if (self.titleConfig.isScrollEnable) {
        CGFloat width = self.scrollView.frame.size.width;
        CGFloat x = willSelecteLabel.center.x - width * 0.5;
        CGRect rect = CGRectMake(x, 0, width, self.scrollView.height);
        [self.scrollView scrollRectToVisible:rect animated:YES];
    }
}


-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

-(NSMutableArray<UILabel *> *)titleLabels{
    if (_titleLabels == nil) {
        _titleLabels = [[NSMutableArray alloc] init];
    }
    return _titleLabels;
}

-(UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = self.titleConfig.bottomLineColor;
        CGFloat height = self.titleConfig.bottomLineHeight;
        CGFloat y = self.bounds.size.height - self.titleConfig.bottomLineHeight;
        _bottomLine.frame = CGRectMake(0, y, self.bounds.size.width, height);
        
    }
    return _bottomLine;
}


-(void)contentViewScroll:(SDPageContentView *)contentView targetIndex:(NSInteger)targetIndex{
    
    [self adjustTitleLabelWithTargetIndex:targetIndex];
}

-(void)contentViewScroll:(SDPageContentView *)contentView targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress{
    
    if (progress > 1.0) {
        return;
    }
   
    //1.取出label
    UILabel *didSelectLabel = self.titleLabels[self.titleConfig.targetIndex];
    UILabel *willSelecteLabel = self.titleLabels[targetIndex];
    
    //2.颜色渐变
    willSelecteLabel.textColor = self.titleConfig.normalColor;
    didSelectLabel.textColor = self.titleConfig.selectedColor;
//    let deltaRGB = UIColor.getRGBDelta(style.selectedColor, style.normalColor)
//    let selectRGB = style.selectedColor.getRGB()
//    let normalRGB = style.normalColor.getRGB()
//    willSelecteLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
//    didSelectLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
    // 3.bottomLine渐变过程
    if (self.titleConfig.isShowBottomLine) {
        CGFloat deltaX = willSelecteLabel.frame.origin.x - didSelectLabel.frame.origin.x;
        CGFloat deltaW = willSelecteLabel.frame.size.width - didSelectLabel.frame.size.width;
        CGFloat x = didSelectLabel.frame.origin.x + deltaX * progress;
        CGFloat width = didSelectLabel.frame.size.width + deltaW * progress;
        self.bottomLine.frame = CGRectMake(x, self.bottomLine.origin.y, width, self.bottomLine.bounds.size.height);
     }

    
}


@end
