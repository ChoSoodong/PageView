




#import "SDSrollPageTitleConfig.h"

@implementation SDSrollPageTitleConfig

-(instancetype)init{
    if (self = [super init]) {
        _isScrollEnable = YES;
        _isShowBottomLine = YES;
    }
    return self;
}

-(CGFloat)titleHeight{
    if (_titleHeight == 0.0) {
        _titleHeight = 44.0f;
    }
    return _titleHeight;
}

-(UIColor *)normalColor{
    if (_normalColor == nil) {
        _normalColor = [ThemeColorTool normalColor];
    }
    return _normalColor;
}

-(UIColor *)selectedColor{
    if (_selectedColor == nil) {
        _selectedColor = [ThemeColorTool selectedColor];
    }
    return _selectedColor;
}

-(CGFloat)fontSize{
    if (_fontSize == 0.0) {
        _fontSize = 14.0f;
    }
    return _fontSize;
}


-(CGFloat)itemMargin{
    if (_itemMargin == 0.0f) {
        _itemMargin = 25.0f;
    }
    return _itemMargin;
}

-(CGFloat)bottomLineHeight{
    if (_bottomLineHeight == 0.0f) {
        _bottomLineHeight = 2.0f;
    }
    return _bottomLineHeight;
}

-(UIColor *)bottomLineColor{
    if (_bottomLineColor == nil) {
        _bottomLineColor = [UIColor orangeColor];
    }
    return _bottomLineColor;
}

@end
