//
//  ViewController.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/9/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MonthPickerViewController.h"
#import "FastingViewController.h"
#import "Constant.h"
#import "UIColor+Extends.h"
#import "UIDevice+Extends.h"
#import "NVDate.h"
	
@import GoogleMobileAds;

#define HEIGHT_IPHONE5 568
#define HEIGHT_IPHONE6 667
#define HEIGHT_IPHONE6P 736

#define WIDTH_IPHONE5 320
#define WIDTH_IPHONE6 375
#define WIDTH_IPHONE6P 414

@interface ViewController ()<UIGestureRecognizerDelegate, UIScrollViewDelegate, MonthPickerDelegate, GADBannerViewDelegate> {
    NSMutableDictionary *_fastings;
    NSArray *_fastingBaseColors;
    NSArray *_fastingBaseColorsForToolbar;
    NSArray *_fastingsName;
    IBOutlet UIView *_overlay;
    IBOutlet UIView *_toolbarBorder;
    IBOutlet UIView *_toolbarView;
    __weak IBOutlet UIView *_toolbarViewBackground;
    IBOutlet UIView *_toolbarViewContent;
    IBOutlet UIView *_toolbarTrigger;
    IBOutlet UIButton *_btnPrev;
    IBOutlet UIButton *_btnNext;
    IBOutlet UIView *_toolbarFastingOther;
    IBOutlet UIButton *_btnMonth;
    IBOutlet UIButton *_btnInfo;
    IBOutlet UIButton *_btnBook;
    IBOutlet UIView *_labelYear;
    IBOutlet UIImageView *_imageTitle;
    IBOutlet UITextView *_yearNote;
    
    IBOutlet UIScrollView *_calendarScrollView;
    
    UIView *currentDay;
    
    BOOL isViewAppeared;
    CGPoint startTapPoint;
    
    MonthPickerViewController *_picker;
    BOOL isViewDidLoad;
    BOOL isViewDidLayoutSubviews;
    BOOL fromTop;
    
    BOOL showHijriyyahDay;
    BOOL isFavoriteMode;
    BOOL adLoaded;
    IBOutlet UIView *bannerView;
    __weak IBOutlet GADBannerView *adsBannerView;
    IBOutlet NSLayoutConstraint *bannerViewConstraintHeight;
    
    IBOutlet UIButton *btnRateNo;
    IBOutlet UIButton *btnRateYes;
    IBOutlet UIView *viewRate;
    IBOutlet NSLayoutConstraint *constraintHeightViewRate;
}
@end

@implementation ViewController
    
- (void)viewDidLoad {
    isViewDidLoad = YES;
    fromTop = NO;
    showHijriyyahDay = YES;
    
    [super viewDidLoad];
    
    [self prepareFasting];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate prepareFastingNotification: _fastDateAll];
    [appDelegate prepareCalendarEvent: _fastDateAll];
}
    
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (isViewDidLayoutSubviews) { return; }
    isViewDidLayoutSubviews = true;
    
    _toolbarFastingOther.backgroundColor = [UIColor withHexString:@"f2f2f2"];
    
    _overlay.hidden = YES;
    _overlay.alpha = 0;
    
    int viewHeight = self.view.frame.size.height;
    int viewWidth = self.view.frame.size.width;
    
    NSLog(@"view size %d %d", viewWidth, viewHeight);
    
    if ([UIDevice isIPad]) {
        CGSize containerSize = CGSizeMake(768, (viewHeight > 1024) ? 960 : 840);
        _calendarScrollView.frame = CGRectMake(
            (viewWidth - 768) / 2,
            110,
            containerSize.width,
            containerSize.height
        );
        _calendarScrollView.contentSize = CGSizeMake(
            containerSize.width * 3,
            containerSize.height
        );
        
        int c = 0;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 4; j++) {
                UIView *section = [_calendarScrollView viewWithTag:10 + c];
                c++;
                
                CGRect sectionFrame = CGRectZero;
                sectionFrame.size.width = 320;
                sectionFrame.size.height = 380;
                sectionFrame.origin.x = (containerSize.width * i) + ((j % 2) == 0 ? 0 : (containerSize.width / 2));
                sectionFrame.origin.y = (j < 2) ? 0 : (containerSize.height / 2);
                
                sectionFrame.origin.x += ((containerSize.width / 2) - sectionFrame.size.width) / 2;
                sectionFrame.origin.y += ((containerSize.height / 2) - sectionFrame.size.height) / 2;
                
                section.frame = sectionFrame;
            }
        }
        
        /* label */ {
            UILabel *labelYear1 = [_labelYear.subviews objectAtIndex:0];
            labelYear1.text = [NSString stringWithFormat:@"%d Masehi", [Constant getCurrentYear]];
            UILabel *labelYear2 = [_labelYear.subviews objectAtIndex:1];
            labelYear2.text = [NSString stringWithFormat:@"%@ - %@ Hijriyah", [Constant getYearsHijriyah][0], [Constant getYearsHijriyah][1]];
        }
        
        int btnPadding = ((viewWidth - containerSize.width) / 2);
        if (btnPadding < 10) {
            btnPadding = 20;
        }
        
        /* _btnPrev */ {
            CGRect f = _btnPrev.frame;
            f.origin.y = containerSize.height / 2 + _calendarScrollView.frame.origin.y - 15;
            f.origin.x = 0 + btnPadding;
            _btnPrev.frame = f;
        }
        
        /* _btnNext */ {
            CGRect f = _btnNext.frame;
            f.origin.y = containerSize.height / 2 + _calendarScrollView.frame.origin.y - 15;
            f.origin.x = viewWidth - f.size.width - btnPadding;
            _btnNext.frame = f;
        }
            
        [self prepareFastingViewForIpad];
    } else {
        int viewWidth320 = 320;
        
        int calendarYInitial = 0;
        int buttonTopPositionInitial = 0;

        if ([UIDevice isIphones_4_4s]) {
            // initial value used
        } else if ([UIDevice isIphones_5_5s_5c_SE]) {
            // initial value used
        } else if ([UIDevice isIphones_6_6s_7_8]) {
            buttonTopPositionInitial = 10;
        } else {
            calendarYInitial = 40;
            buttonTopPositionInitial = 47;
        }
        
        int calendarY = calendarYInitial;
        int buttonTopPosition = 35 + buttonTopPositionInitial;
        int buttonBottomPosition = viewHeight - 105 - [self getAdsHeight];
        
        int leftPadding = 0;
        if (viewWidth != viewWidth320) {
            leftPadding = (viewWidth - viewWidth320) / 2.;
        }
        
        /* _calendarScrollView */ {
            int calendarHeight = viewHeight - calendarY;
            
            CGRect calendarScrollViewFrame = _calendarScrollView.frame;
            calendarScrollViewFrame.origin.y = calendarY;
            calendarScrollViewFrame.size.width = viewWidth;
            calendarScrollViewFrame.size.height = calendarHeight;
            _calendarScrollView.frame = calendarScrollViewFrame;
        }
        
        /* _overlay */ {
            CGRect overlayFrame = _overlay.frame;
            overlayFrame.size.width = viewWidth;
            overlayFrame.size.height = viewHeight;
            _overlay.frame = overlayFrame;
        }
        
        // ========== button top
        
        /* _btnNext */ {
            CGRect btnNextFrame = _btnNext.frame;
            btnNextFrame.origin.y = buttonTopPosition;
            btnNextFrame.origin.x = viewWidth - btnNextFrame.size.width - 22;
            _btnNext.frame = btnNextFrame;
        }
        
        /* _btnPrev */ {
            CGRect btnPrevFrame = _btnPrev.frame;
            btnPrevFrame.origin.y = buttonTopPosition;
            btnPrevFrame.origin.x = 22;
            _btnPrev.frame = btnPrevFrame;
        }
        
        // ========== button bottom
        
        /* _btnInfo */ {
            CGRect btnInfoFrame = _btnInfo.frame;
            btnInfoFrame.origin.x = (viewWidth / 4 * 3) + 10;
            btnInfoFrame.origin.y = buttonBottomPosition;
            _btnInfo.frame = btnInfoFrame;
        }
        
        /* _btnMonth */ {
            CGRect btnMonthFrame = _btnMonth.frame;
            btnMonthFrame.origin.x = (viewWidth / 4 * 3) - btnMonthFrame.size.width - 10;
            btnMonthFrame.origin.y = buttonBottomPosition;
            _btnMonth.frame = btnMonthFrame;
        }
        
        /* _yearNote */ {
            CGRect yearNoteFrame = _yearNote.frame;
            yearNoteFrame.size.width = viewWidth / 2;
            yearNoteFrame.origin.x = 0;
            yearNoteFrame.origin.y = buttonBottomPosition;
            _yearNote.frame = yearNoteFrame;
            _yearNote.text = [NSString stringWithFormat:@"%d Masehi\n%@ - %@ Hijriyah", [Constant getCurrentYear], [Constant getYearsHijriyah][0], [Constant getYearsHijriyah][1]];
            _yearNote.textColor = [UIColor withHexString:@"454744"];
            _yearNote.textAlignment = NSTextAlignmentCenter;
        }
        
        // ========== toolbar
        
        /* _toolbarView */ {
            int viewHeight = self.view.frame.size.height;
            
            CGRect toolbarViewFrame = CGRectMake(0, viewHeight - [self getAdsHeight] - 70, viewWidth, 486 + [self getAdsHeight]);
            _toolbarView.frame = toolbarViewFrame;
            
            CGRect toolbarViewBackgroundFrame = _toolbarViewBackground.frame;
            toolbarViewBackgroundFrame.size.width = toolbarViewFrame.size.width;
            _toolbarViewBackground.frame = toolbarViewBackgroundFrame;
            _toolbarViewBackground.backgroundColor = _toolbarFastingOther.backgroundColor;
            
            [self prepareToolbarViewForIphone];
        }
        
        /* _toolbarView button */ {
            UIButton *toolbarButton = (UIButton *)[_toolbarView viewWithTag:1];
            CGRect toolbarButtonFrame = toolbarButton.frame;
            toolbarButtonFrame.size.width = viewWidth;
            toolbarButton.frame = toolbarButtonFrame;
        }
        
        /* _toolbarTrigger */ {
            CGRect toolbarTriggerFrame = _toolbarTrigger.frame;
            toolbarTriggerFrame.origin.x = (viewWidth - toolbarTriggerFrame.size.width) / 2;
            _toolbarTrigger.frame = toolbarTriggerFrame;
        }
        
        /* _toolbarBorder */ {
            CGRect toolbarBorderFrame = _toolbarBorder.frame;
            toolbarBorderFrame.size.width = viewWidth;
            _toolbarBorder.frame = toolbarBorderFrame;
            
            UITextView *toolbarBorderText = (UITextView *)_toolbarBorder.subviews.firstObject;
            CGRect toolbarBorderTextFrame = toolbarBorderText.frame;
            toolbarBorderTextFrame.origin.x = 10;
            toolbarBorderTextFrame.size.width = viewWidth - (toolbarBorderTextFrame.origin.x * 2);
            toolbarBorderText.frame = toolbarBorderTextFrame;
        }
        
        /* _toolbarViewContent */ {
            CGRect toolbarBorderFrame = _toolbarViewContent.frame;
            toolbarBorderFrame.origin.x = leftPadding;
            _toolbarViewContent.frame = toolbarBorderFrame;
            
            for (UIView *each in _toolbarViewContent.subviews) {
                UIView *eachCover = each.subviews.firstObject;
                
                eachCover.layer.cornerRadius = 4.;
                eachCover.clipsToBounds = YES;
            }
        }
        
        /* _toolbarFastingOther */ {
            CGRect toolbarFastingOtherFrame = _toolbarFastingOther.frame;
            toolbarFastingOtherFrame.origin.x = leftPadding;
            _toolbarFastingOther.frame = toolbarFastingOtherFrame;
        }
        
        self.view.backgroundColor = [UIColor withHexString:@"f1f2f4"];
        [self prepareFastingViewForIphone];
    }
    
    btnRateNo.backgroundColor = [UIColor clearColor];
    [btnRateNo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRateNo.layer.borderWidth = 2;
    btnRateNo.layer.cornerRadius = 6;
    btnRateNo.layer.borderColor = [UIColor whiteColor].CGColor;
    
    btnRateYes.backgroundColor = [UIColor whiteColor];
    [btnRateYes setTitleColor:viewRate.backgroundColor forState:UIControlStateNormal];
    btnRateYes.layer.borderWidth = 2;
    btnRateYes.layer.cornerRadius = 6;
    btnRateYes.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.view bringSubviewToFront:viewRate.superview];
    
    if ([self getAdsHeight] == 0) {
        bannerView.hidden = YES;
    } else {
        bannerViewConstraintHeight.constant = [self getAdsHeight];
        [bannerView layoutIfNeeded];
        [bannerView layoutSubviews];
    }
}
    
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!isViewDidLoad) return;
    isViewDidLoad = NO;
    
    [self prepareCalendarView];

    [RateHelper whenRateViewTimeDo:^{
        self->viewRate.superview.hidden = false;
    }];
    
    [self prepareBanner];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)prepareCalendarView {
    if ([UIDevice isIPad]) {
        _calendarScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, _calendarScrollView.frame.size.height);
    }
    
    long currentMonthIndex = ([[self getDateComponents] month] - 1);
    if ([UIDevice isIPad]) currentMonthIndex = floor(currentMonthIndex / 4);
    
    [UIView animateWithDuration:.3 animations:^{
        self->_calendarScrollView.contentOffset = CGPointMake(currentMonthIndex * self->_calendarScrollView.frame.size.width, 0);
    }];
    
    _btnPrev.enabled = !(currentMonthIndex <= 0);
    _btnNext.enabled = !(currentMonthIndex >= [self maxPage]);
}

- (void)prepareFasting {
    _fastings = [[NSMutableDictionary alloc] initWithDictionary:[Constant getFastingDates]];
    _fastingBaseColors = [[NSArray alloc] initWithArray:[Constant getFastingBaseColors]];
    _fastingsName = [[NSArray alloc] initWithArray:[Constant getFastingNames]];
    _fastingBaseColorsForToolbar = @[_fastingBaseColors[5],
                                     _fastingBaseColors[4],
                                     _fastingBaseColors[0],
                                     _fastingBaseColors[1],
                                     _fastingBaseColors[2],
                                     _fastingBaseColors[3]];
    _fastDateAll = [NSMutableArray array];
}
    
- (void)prepareFastingViewForIphone {
    int viewWidth320 = 320;
    int viewWidth = self.view.frame.size.width;
    
    int i = 0;
    
    for (NSString *month in [Constant getMonthsName]) {
        int leftPosition = i * viewWidth;
        int leftPadding = 0;
        int topPadding = 0;
        
        if (viewWidth != viewWidth320) {
            leftPadding = (viewWidth - viewWidth320) / 2;
            topPadding = leftPadding / 3.;
        }
        
        UIColor *currentColor = [UIColor withHexString:[Constant getMonthsBaseColor][i]];
        
        CGRect headerFrame = CGRectMake(viewWidth, 115, viewWidth, 38);
        UIView *headerView = [self getDayHeaderWithBackgroundColor:currentColor forIndex:i withRect:headerFrame];
        [_calendarScrollView addSubview:headerView];
        
        NSArray *inames = [[[Constant getMonthsMapping] valueForKey:month] valueForKey:@"iname"];
        CGRect titleSubFrame = CGRectMake(leftPosition + leftPadding + 10, 68, 300, 40);
        UILabel *titleSub = [[UILabel alloc] initWithFrame:titleSubFrame];
        titleSub.backgroundColor = [UIColor clearColor];
        titleSub.textAlignment = NSTextAlignmentCenter;
        titleSub.text = (inames.count > 1) ? [NSString stringWithFormat:@"%@ - %@", inames[0], inames[1]] : inames[0];
        titleSub.font = [UIFont fontWithName:@"Lato-Medium" size:13];
        titleSub.textColor = currentColor;
        [_calendarScrollView addSubview:titleSub];
        
        CGRect titleFrame = CGRectMake(leftPosition + leftPadding + 10, 26, 300, 50);
        UILabel *title = [[UILabel alloc] initWithFrame:titleFrame];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = month;
        title.textColor = currentColor;
        title.font = [UIFont fontWithName:@"Lato-Black" size:42];
        
        if (!([UIDevice isIphones_4_4s] || [UIDevice isIphones_5_5s_5c_SE])) {
            title.attributedText = [[NSAttributedString alloc] initWithString:month
                                                                   attributes:@{ NSKernAttributeName : @(2.8) }];
        }

        [_calendarScrollView addSubview:title];
        
        UIView *monthView = [self prepareFastingForMonth:month];
        monthView.frame = CGRectMake(10, 10, monthView.frame.size.width, monthView.frame.size.height);
        
        CGRect monthBridgerFrame = CGRectMake(10, 0, monthView.frame.size.width + 20, monthView.frame.size.height + 20);
        UIView *monthBridger = [[UIView alloc] initWithFrame:monthBridgerFrame];
        [monthBridger addSubview:monthView];
        monthBridger.clipsToBounds = YES;
        
        CGRect monthContainerFrame = CGRectMake(leftPosition + leftPadding, 168 + topPadding, viewWidth320, 300);
        UIView *monthContainer = [[UIView alloc] initWithFrame:monthContainerFrame];
        monthContainer.tag = monthView.tag;
        [monthContainer addSubview:monthBridger];
        [_calendarScrollView addSubview:monthContainer];
        
        i++;
    }
    
    _calendarScrollView.contentSize = CGSizeMake(viewWidth * 12, 300);
}
    
- (void)prepareFastingViewForIpad {
    int i = 0;
    
    UIView *block;
    
    for (NSString *month in [Constant getMonthsName]) {
        
        block = [_calendarScrollView viewWithTag:(10 + i)];
        
        UIColor *currentColor = [UIColor withHexString:[Constant getMonthsBaseColor][i % 4]];
        
        UIView *header = [self getDayHeaderWithBackgroundColor:currentColor forIndex:i withRect:CGRectZero];
        header.frame = CGRectMake(0, 85, 320, 38);
        [block addSubview:header];
        
        NSArray *inames = [[[Constant getMonthsMapping] valueForKey:month] valueForKey:@"iname"];
        UILabel *titleSub = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 300, 40)];
        titleSub.backgroundColor = [UIColor clearColor];
        titleSub.textAlignment = NSTextAlignmentCenter;
        titleSub.text = (inames.count > 1) ? [NSString stringWithFormat:@"%@ - %@", inames[0], inames[1]] : inames[0];
        titleSub.font = [UIFont fontWithName:@"Lato-Medium" size:13];
        titleSub.textColor = currentColor;
        [block addSubview:titleSub];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = month;
        title.textColor = currentColor;
        title.font = [UIFont fontWithName:@"Lato-Black" size:42];
        title.attributedText = [[NSAttributedString alloc] initWithString:month
                                                               attributes:@{ NSKernAttributeName : @(2.8) }];
        [block addSubview:title];
        
        UIView *monthView = [self prepareFastingForMonth:month];
        monthView.frame = CGRectMake(10, 10, monthView.frame.size.width, monthView.frame.size.height);
        
        UIView *monthBridger = [[UIView alloc] initWithFrame:CGRectMake(10, 0, monthView.frame.size.width + 20, monthView.frame.size.height + 20)];
        [monthBridger addSubview:monthView];
        monthBridger.clipsToBounds = YES;
        
        UIView *monthContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 138, 320, 300)];
        monthContainer.tag = monthView.tag;
        [monthContainer addSubview:monthBridger];
        [block addSubview:monthContainer];
        
        i++;
    }
}

- (CGFloat)getAdsHeight {
    if (![Constant isAdsEnabled]) {
        return 0;
    }

    CGFloat deviceHeight = UIScreen.mainScreen.bounds.size.height;
    if (deviceHeight <= 568) {
        return 0;
    }
    
    if (deviceHeight > 568 && deviceHeight <= 720) {
        return 50;
    } else {
        return 90;
    }
}
    
- (void)prepareToolbarViewForIphone {
    _overlay.backgroundColor = [UIColor withRGBA:@"0,0,0,.9"];
    _overlay.hidden = YES;
    _overlay.alpha = 0;
    
    _toolbarViewContent.backgroundColor = [UIColor withHexString:@"f2f2f2"];
    
    _toolbarBorder.backgroundColor = [UIColor withHexString:@"454744"];
    
    _toolbarTrigger.backgroundColor = [UIColor clearColor];
    
    int i = 0;
    
    for (UIView *view in [_toolbarViewContent subviews]) {
        if (i >= 6) return;
        
        UIView *cover = [view.subviews objectAtIndex:0];
        cover.backgroundColor = [UIColor withHexString:_fastingBaseColorsForToolbar[i]];
        
        UILabel *text = [view.subviews objectAtIndex:1];
        text.textColor = [UIColor withHexString:_fastingBaseColorsForToolbar[i++]];
    }
}
    
- (IBAction)doCancelToolbar:(id)sender {
    int viewHeight = self.view.frame.size.height;
    int toolbarViewStartPosition = viewHeight - [self getAdsHeight] - 70;
    
    if (_toolbarView.frame.origin.y == toolbarViewStartPosition) {
        return;
    }
    
    [UIView animateWithDuration:.4 animations:^{
        CGRect toolbarViewFrame = self->_toolbarView.frame;
        toolbarViewFrame.origin.y = toolbarViewStartPosition;
        self->_toolbarView.frame = toolbarViewFrame;
        
        self->_overlay.alpha = 0;
    } completion:^(BOOL finished) {
        self->_overlay.hidden = YES;
    }];
}
    
- (void)tapFastingHelp:(UIButton *)sender {
    
}
    
- (UIView *)getDayHeaderWithBackgroundColor:(UIColor *)backgroundColor forIndex:(int)index withRect:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(index * frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    view.backgroundColor = backgroundColor;
    
    NSArray *days = @[@"A", @"S", @"S", @"R", @"K", @"J", @"S"];
    
    int paddingLeft = 20;
    
    int viewWidth320 = 320;
    int viewWidth = self.view.frame.size.width;
    
    if (![UIDevice isIPad] && viewWidth != viewWidth320) {
        paddingLeft += (viewWidth - viewWidth320) / 2;
    }
    
    for (int i = 0; i < days.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 40 + paddingLeft, 0, 38, 38)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = days[i];
        label.font = [UIFont fontWithName:@"OpenSans-Bold" size:16];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        
        [view addSubview:label];
    }
    
    return view;
}
    
- (UIView *)prepareFastingForMonth:(NSString *)monthName {
    NSDictionary *month = [[Constant getMonthsMapping] valueForKey:monthName];
    int left     = [[month valueForKey:@"left"] intValue];
    int length   = [[month valueForKey:@"length"] intValue];
    int max      = left + length;
    int cellSize = 40;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellSize * 7, cellSize * (((max - 1) / 7) + 1))];
    for (int i = 0; i < max; i++) {
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake((i % 7) * cellSize + 1, (i / 7) * cellSize + 1, cellSize - 2, cellSize - 2)];
        
        if (!((i + 1) > left)) {
            continue;
        }
        
        int dayNumber = i - left + 1;
        
        dayLabel.text = [NSString stringWithFormat:@"%d", dayNumber];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:17];
        dayLabel.tag = -1;
        dayLabel.backgroundColor = ([UIDevice isIPad] ? [UIColor clearColor] : [UIColor withHexString:@"f1f2f4"]);
        
        if (i % 7 == 0) {
            dayLabel.textColor = [UIColor withHexString:@"ed1e22"];
        } else {
            dayLabel.textColor = [UIColor withHexString:@"212429"];
        }
        
        [self fastingableFor:@"Puasa Ramadhan"          at:dayNumber withData:month inLabel:dayLabel withBGColor:[UIColor withHexString:_fastingBaseColors[0]] andTextColor:[UIColor withHexString:@"ffffff"]];
        [self fastingableFor:@"Haram Berpuasa"          at:dayNumber withData:month inLabel:dayLabel withBGColor:[UIColor withHexString:_fastingBaseColors[1]] andTextColor:[UIColor withHexString:@"ffffff"]];
        [self fastingableFor:@"Puasa Arafah"            at:dayNumber withData:month inLabel:dayLabel withBGColor:[UIColor withHexString:_fastingBaseColors[2]] andTextColor:[UIColor withHexString:@"ffffff"]];
        [self fastingableFor:@"Puasa Asyura dan Tasu'a" at:dayNumber withData:month inLabel:dayLabel withBGColor:[UIColor withHexString:_fastingBaseColors[3]] andTextColor:[UIColor withHexString:@"ffffff"]];
        [self fastingableFor:@"Puasa Ayyamul Bidh"      at:dayNumber withData:month inLabel:dayLabel withBGColor:[UIColor withHexString:_fastingBaseColors[4]] andTextColor:[UIColor withHexString:@"ffffff"]];
        [self fastingableForMondayThursdayAt:dayNumber byLeftSpacing:left withData:month inLabel:dayLabel withBGColor:[UIColor withHexString:_fastingBaseColors[5]] andTextColor:[UIColor withHexString:@"ffffff"]];
        
        [view addSubview:dayLabel];
        
        if (showHijriyyahDay) {
            NSArray *hdays = [month valueForKey:@"hijriyahday1"];
            
            NSString *previousMonthName = @"";
            NSDictionary *previousMonth = @{};
            for (NSString *eachMonth in [Constant getMonthsName]) {
                if (eachMonth == monthName) {
                    break;
                }
                
                previousMonthName = eachMonth;
                previousMonth = [[Constant getMonthsMapping] valueForKey:previousMonthName];
            }
            
            bool hDay1 = false;
            int hDayLast = 0;
            
            if (hdays.count == 0) {
                
            } else if (hdays.count == 1) {
                if (dayNumber < [hdays.firstObject intValue]) {
                    hDay1 = true;
                }
                
                hDayLast = [hdays.firstObject intValue];
            } else if (hdays.count == 2) {
                if (dayNumber < [hdays.firstObject intValue]) {
                    hDay1 = true;
                } else {
                    if (dayNumber < [hdays.lastObject intValue]) {
                        hDayLast = [hdays.firstObject intValue];
                    } else {
                        hDayLast = [hdays.lastObject intValue];
                    }
                }
            }
            
            
            NSLog(@"month name %@", monthName);
            NSLog(@"prev month name %@ %@", previousMonthName, previousMonth);
            NSLog(@"dayNumber %d", dayNumber);
            NSLog(@"hday1 %d", hDay1);
            NSLog(@"hdaylast %d", hDayLast);
            
            NSString *hDay = @"";
            if (hDay1) {
                // continue from last month
                
                int previousMonthHDay = [[[previousMonth valueForKey:@"hijriyahday1"] lastObject] intValue];
                // hack if in a month there are two hijriyah 1 dates.
                if (hdays.count == 2) {
                    previousMonthHDay = [[hdays firstObject] intValue];
                }
                
                int prevMonthLength = [[previousMonth valueForKey:@"length"] intValue];
                if ([previousMonthName isEqualToString:@""]) {
                    prevMonthLength = [[month valueForKey:@"prevhijriyahstart"] intValue];
                }
                
                int v = prevMonthLength - previousMonthHDay + dayNumber + 1;
                
                if (![monthName isEqual: @"Januari"]) {
                    hDay = [NSString stringWithFormat:@"%d", v];
                }
            } else {
                // start from day 1 hijriyyah
                
                int v = dayNumber - hDayLast + 1;
                hDay = [NSString stringWithFormat:@"%d", v];
            }
            
            UILabel *hDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -12, dayLabel.frame.size.width - 4, dayLabel.frame.size.height)];
            
            NSString *hDayArabic = @"";
            for (int i = 0; i < hDay.length; i++) {
                int dayInt = [[hDay substringWithRange:NSMakeRange(i, 1)] intValue];
                hDayArabic = [NSString stringWithFormat:@"%@%@", hDayArabic, [Constant getNumbersInArabic][dayInt]];
            }
            
            hDayLabel.text = hDayArabic;
            hDayLabel.font = [UIFont fontWithName:@"OpenSans" size:9];
            hDayLabel.textAlignment = NSTextAlignmentRight;
            hDayLabel.textColor = [UIColor withHexString:@"212429"];
            hDayLabel.textColor = (dayLabel.tag == -1) ? [UIColor withHexString:@"212429"] : [UIColor whiteColor];
            
            [dayLabel addSubview:hDayLabel];
        }
    }
    
    view.tag = [[Constant getMonthsName] indexOfObject:monthName] + 1;
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
    
- (void)fastingableFor:(NSString *)fastingName at:(int)dayNumber withData:(NSDictionary *)data inLabel:(UILabel *)label withBGColor:(UIColor *)bgColor andTextColor:(UIColor *)textColor {
    id options = [[[_fastings valueForKey:fastingName] valueForKey:@"month"] valueForKey:[data valueForKey:@"name"]];
    if (!options) return;
    
    NSMutableDictionary *values = [NSMutableDictionary dictionary];
    
    if ([options isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)options count] > 2) {
            for (id i in options)
            values[[i stringValue]] = @(true);
        } else {
            int start  = [[options objectAtIndex:0] intValue];
            int finish = [[options objectAtIndex:1] intValue];
            for (int i = start; i <= finish; i++) values[@(i).stringValue] = @(true);
        }
    } else {
        values[[options stringValue]] = @(true);
    }
    
    if (!(values[@(dayNumber).stringValue] && label.tag == -1)) return;
    
    label.backgroundColor = bgColor;
    label.textColor = textColor;
    label.tag = [_fastingsName indexOfObject:fastingName];
    
    UIImageView *cover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover.png"]];
    cover.frame = CGRectMake(0, 0, label.frame.size.width, label.frame.size.height);
    [label addSubview:cover];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fastTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [label addGestureRecognizer:tapGesture];
    label.userInteractionEnabled = YES;
    
    long monthNumber = [[Constant getMonthsName] indexOfObject:[data valueForKey:@"name"]] + 1;
    long year = [[NVDate alloc] initUsingToday].year;
    NVDate *date = [[NVDate alloc] initUsingYear:year month:monthNumber day:dayNumber];
    
    NSDictionary *currentMonthData = [[Constant getMonthsMapping] valueForKey:[data valueForKey:@"name"]];
    int dayIndex = (dayNumber + [[currentMonthData valueForKey:@"left"] intValue] - 1) % 7;
    [_fastDateAll addObject:@{@"fastingName": fastingName, @"day": @(dayNumber), @"dayName": [Constant getDaysName][dayIndex], @"month": @(monthNumber), @"monthName": [data valueForKey:@"name"]}];
    date = nil;
}
    
- (void)fastingableForMondayThursdayAt:(int)dayNumber byLeftSpacing:(int)left withData:(NSDictionary *)data inLabel:(UILabel *)label withBGColor:(UIColor *)bgColor andTextColor:(UIColor *)textColor {
    int dayIndex = (dayNumber + left - 1) % 7;
    if (!((dayIndex == 1 || dayIndex == 4) && label.tag == -1)) return;
    
    label.backgroundColor = bgColor;
    label.textColor = textColor;
    label.tag = [_fastingsName indexOfObject:@"Puasa Senin Kamis"];
    
    UIImageView *cover = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover.png"]];
    cover.frame = CGRectMake(0, 0, label.frame.size.width, label.frame.size.height);
    [label addSubview:cover];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fastTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [label addGestureRecognizer:tapGesture];
    label.userInteractionEnabled = YES;
    
    long monthNumber = [[Constant getMonthsName] indexOfObject:[data valueForKey:@"name"]] + 1;
    long year = [[NVDate alloc] initUsingToday].year;
    NVDate *date = [[NVDate alloc] initUsingYear:year month:monthNumber day:dayNumber];
    
    [_fastDateAll addObject:@{@"fastingName": @"Puasa Senin Kamis", @"day": @(dayNumber), @"dayName": [Constant getDaysName][dayIndex], @"month": @(monthNumber), @"monthName": [data valueForKey:@"name"]}];
    date = nil;
}
    
- (void)fastTap:(UIGestureRecognizer *)recognizer {
    if (recognizer.view.tag < 0) return;
    
    NSString *title = @"Notifikasi";
    NSString *message;
    
    if ([_fastingsName[recognizer.view.tag] isEqualToString:@"Haram Berpuasa"]) {
        message = [NSString stringWithFormat:@"Tanggal %@ Diharamkan Berpuasa", [(UILabel *)recognizer.view text]];
    } else if ([_fastingsName[recognizer.view.tag] isEqualToString:@"Puasa Ramadhan"]) {
        message = [NSString stringWithFormat:@"Tanggal %@ Diwajibkan Berpuasa Ramadhan", [(UILabel *)recognizer.view text]];
    } else {
        message = [NSString stringWithFormat:@"Tanggal %@ Disunnahkan %@", [(UILabel *)recognizer.view text], _fastingsName[recognizer.view.tag]];
    }
    
    if (recognizer.view.subviews.count > 1) {
        message = [message stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"Tanggal %@", [(UILabel *)recognizer.view text]] withString:[NSString stringWithFormat:@"Hari ini tanggal %@", [(UILabel *)recognizer.view text]]];
    }
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}
    
- (NSDateComponents *)getDateComponents {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    return dateComponents;
}
    
- (NSDictionary *)whatNextFasting {
    long currentMonth = [[self getDateComponents] month];
    long currentday   = [[self getDateComponents] day];
    
    UIView *currentMonthView;
    if ([UIDevice isIPad])
    currentMonthView = [[[_calendarScrollView.subviews[currentMonth - 1] subviews].lastObject subviews][0] subviews][0];
    else
    currentMonthView = [[_calendarScrollView.subviews[(currentMonth - 1) * 4 + 3] subviews][0] subviews][0];
    
    int space = 0;
    
    UILabel *selectedLabel;
    long nextFasting = -1;
    for (long i = currentday + 1; i <= currentMonthView.subviews.count; i++) {
        selectedLabel = currentMonthView.subviews[i - 1];
        space++;
        if ([selectedLabel tag] > -1) {
            nextFasting = i;
            break;
        }
    }
    
    if (nextFasting > -1) {
        NSDictionary *currentMonthData = [[Constant getMonthsMapping] valueForKey:[Constant getMonthsName][currentMonth - 1]];
        int dayIndex = ([selectedLabel.text intValue] + [[currentMonthData valueForKey:@"left"] intValue] - 1) % 7;
        return @{
                 @"fastingName" : _fastingsName[selectedLabel.tag],
                 @"day"         : selectedLabel.text,
                 @"dayName"     : [Constant getDaysName][dayIndex],
                 @"month"       : @(currentMonth),
                 @"monthName"   : [Constant getMonthsName][currentMonth - 1],
                 @"space"       : @(space)
                 };
    }
    
    if (currentMonth >= 12) return nil;
    
    UIView *nextMonthView;
    if ([UIDevice isIPad])
    nextMonthView = [[[_calendarScrollView.subviews[currentMonth] subviews].lastObject subviews][0] subviews][0];
    else
    nextMonthView = [[_calendarScrollView.subviews[currentMonth * 4 + 3] subviews][0] subviews][0];
    
    selectedLabel = nil;
    nextFasting = -1;
    space++;
    for (int i = 1; i <= nextMonthView.subviews.count; i++) {
        selectedLabel = currentMonthView.subviews[i - 1];
        space++;
        if ([selectedLabel tag] > -1) {
            nextFasting = i;
            break;
        }
    }
    
    if (nextFasting > -1) {
        NSDictionary *nextMonthData = [[Constant getMonthsMapping] valueForKey:[Constant getMonthsName][currentMonth]];
        int dayIndex = ([selectedLabel.text intValue] + [[nextMonthData valueForKey:@"left"] intValue] - 1) % 7;
        return @{
                 @"fastingName" : _fastingsName[selectedLabel.tag],
                 @"day"         : selectedLabel.text,
                 @"dayName"     : [Constant getDaysName][dayIndex],
                 @"month"       : @(currentMonth + 1),
                 @"monthName"   : [Constant getMonthsName][currentMonth],
                 @"space"       : @(space)
                 };
    }
    
    return nil;
}
    
#pragma mark - gesture
    
- (IBAction)tapGestureHandler:(UITapGestureRecognizer *)sender {
    int viewHeight = self.view.frame.size.height;
    int toolbarViewStartPosition = viewHeight - [self getAdsHeight] - 70;
    
    if (_toolbarView.frame.origin.y == toolbarViewStartPosition) {
        _overlay.hidden = NO;
        _overlay.alpha = 0;
        
        [UIView animateWithDuration:.4 animations:^{
            CGRect toolbarViewFrame = self->_toolbarView.frame;
            toolbarViewFrame.origin.y = viewHeight - self->_toolbarView.frame.size.height;
            self->_toolbarView.frame = toolbarViewFrame;
            
            self->_overlay.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:.4 animations:^{
            CGRect toolbarViewFrame = self->_toolbarView.frame;
            toolbarViewFrame.origin.y = toolbarViewStartPosition;
            self->_toolbarView.frame = toolbarViewFrame;
            
            self->_overlay.alpha = 0;
        } completion:^(BOOL finished) {
            self->_overlay.hidden = YES;
        }];
    }
}
    
- (IBAction)panGestureHandler:(UIPanGestureRecognizer *)recognizer {
    int viewHeight = self.view.frame.size.height;
    int toolbarViewStartPosition = viewHeight - [self getAdsHeight] - 70;
    int toolbarViewWidth = _toolbarView.frame.size.width;
    int toolbarViewHeight = _toolbarView.frame.size.height;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startTapPoint = [recognizer locationInView:_toolbarView];
        
        fromTop = !_overlay.hidden;
        
        if (_overlay.hidden) {
            _overlay.hidden = NO;
            _overlay.alpha = 0;
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        int increment = [recognizer locationInView:_toolbarView].y - startTapPoint.y;
        int shouldY = _toolbarView.frame.origin.y + increment;
        
        if (shouldY >= toolbarViewStartPosition) {
            shouldY = toolbarViewStartPosition;
        } else if (shouldY <= viewHeight - toolbarViewHeight) {
            shouldY = viewHeight - toolbarViewHeight;
        }
        
        _overlay.alpha = 1 - (shouldY / (toolbarViewHeight * 1.0));
        _toolbarView.frame = CGRectMake(0, shouldY, toolbarViewWidth, toolbarViewHeight);
    } else {
        if (!fromTop) {
            [UIView animateWithDuration:.4 animations:^{
                CGRect toolbarViewFrame = self->_toolbarView.frame;
                toolbarViewFrame.origin.y = viewHeight - toolbarViewHeight;
                self->_toolbarView.frame = toolbarViewFrame;
                
                self->_overlay.alpha = 1;
            }];
        } else {
            [UIView animateWithDuration:.4 animations:^{
                CGRect toolbarViewFrame = self->_toolbarView.frame;
                toolbarViewFrame.origin.y = toolbarViewStartPosition;
                self->_toolbarView.frame = toolbarViewFrame;
                
                self->_overlay.alpha = 0;
            } completion:^(BOOL finished) {
                self->_overlay.hidden = YES;
            }];
        }
    }
}
    
- (IBAction)doPrevMonth:(UIButton *)sender {
    int currentPage = _calendarScrollView.contentOffset.x / _calendarScrollView.frame.size.width;
    if (currentPage <= 0) return;
    
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.4 animations:^{
        self->_calendarScrollView.contentOffset = CGPointMake((currentPage - 1) * self->_calendarScrollView.frame.size.width, self->_calendarScrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        self->_btnPrev.enabled = !((currentPage - 1) <= 0);
        self->_btnNext.enabled = !((currentPage - 1) >= [self maxPage]);
    }];
}
    
- (IBAction)doNextMonth:(UIButton *)sender {
    int currentPage = _calendarScrollView.contentOffset.x / _calendarScrollView.frame.size.width;
    if (currentPage >= [self maxPage]) return;
    
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.4 animations:^{
        self->_calendarScrollView.contentOffset = CGPointMake((currentPage + 1) * self->_calendarScrollView.frame.size.width, self->_calendarScrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        self->_btnPrev.enabled = !((currentPage + 1) <= 0);
        self->_btnNext.enabled = !((currentPage + 1) >= [self maxPage]);
    }];
}
    
#pragma mark - scrollview
    
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = scrollView.contentOffset.x / _calendarScrollView.frame.size.width;
    
    _btnPrev.enabled = !(currentPage <= 0);
    _btnNext.enabled = !(currentPage >= [self maxPage]);
}
    
#pragma mark - segue
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    if ([segue.identifier isEqualToString:@"SegueCalendar"]) {
        _picker = segue.destinationViewController;
        _picker.delegate = self;
        _picker.monthsBaseColor = [Constant getMonthsBaseColor];
    } else if ([segue.identifier isEqualToString:@"SegueInfo"]) {
        
    } else if ([segue.identifier isEqualToString:@"SegueFasting"]) {
        FastingViewController *fasting = segue.destinationViewController;
        fasting.colors = _fastingBaseColorsForToolbar;
    }
}
    
#pragma mark - monthpicker delegate
    
- (void)doPickMonthAtIndex:(int)index {
    if ([UIDevice isIPad]) {
        index = floor(index / 4);
    }
    
    self.view.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.4 animations:^{
            self->_calendarScrollView.contentOffset = CGPointMake(index * self->_calendarScrollView.frame.size.width, self->_calendarScrollView.contentOffset.y);
            
            if (![UIDevice isIPad]) {
                self->_picker.view.alpha = 0;
            }
        } completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
            self->_btnPrev.enabled = !(index <= 0);
            self->_btnNext.enabled = !(index >= [self maxPage]);
        }];
    });
    
    [_picker dismissViewControllerAnimated:YES completion:nil];
    
}
    
- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}
    
- (int)maxPage {
    return [UIDevice isIPad] ? 2 : 11;
}
    
#pragma mark - current day
    
- (void)prepareForCurrentDay {
    long currentMonth = [[self getDateComponents] month];
    long currentday   = [[self getDateComponents] day];
    
    UIView *currentMonthView;
    if ([UIDevice isIPad]) {
        currentMonthView = [[[_calendarScrollView.subviews[currentMonth - 1] subviews].lastObject subviews][0] subviews][0];
    } else {
        currentMonthView = [[_calendarScrollView.subviews[(currentMonth - 1) * 4 + 3] subviews][0] subviews][0];
    }
    
    UILabel *selectedLabel;
    
    for (int i = 1; i <= currentMonthView.subviews.count; i++) {
        if ([[(UILabel *)currentMonthView.subviews[i - 1] text] intValue] == currentday) {
            selectedLabel = currentMonthView.subviews[i - 1];
            break;
        }
    }
    
    if (currentDay) {
        [currentDay removeFromSuperview];
    }
    if (!selectedLabel) {
        return;
    }
    
    currentDay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selectedLabel.frame.size.width, selectedLabel.frame.size.height)];
    currentDay.layer.cornerRadius = 6.;
    currentDay.layer.borderColor = [UIColor withRGBA:@"0,0,0,.3"].CGColor;
    currentDay.layer.borderWidth = 2.;
    currentDay.backgroundColor = [UIColor withRGBA:@"0,0,0,.1"];
    
    [selectedLabel addSubview:currentDay];
}
    
    
    
#pragma mark - popup modal ad

- (void)prepareBanner {
    if (![Constant isAdsEnabled]) {
        return;
    }

    CGFloat deviceHeight = UIScreen.mainScreen.bounds.size.height;
    if (deviceHeight <= 400) {
        return;
    }
    
    CGFloat adsHeight = [self getAdsHeight];
    NSLog(@"ADS HEIGHT %f", adsHeight);
    
    adLoaded = NO;
    bannerViewConstraintHeight.constant = adsHeight;
    [bannerView.superview layoutSubviews];
    [bannerView layoutIfNeeded];
    
    if ([UIDevice isIPad]) {
        [bannerView setBackgroundColor:[UIColor whiteColor]];
    } else {
        [bannerView setBackgroundColor:[UIColor withHexString:@"#242524"]];
    }
    
    adsBannerView.adUnitID = [Constant getAdMobPubID];
    adsBannerView.adSize = kGADAdSizeSmartBannerPortrait;
    
    GADRequest *request = [GADRequest request];
    
    [adsBannerView loadRequest:request];
}
    
- (void)adViewDidReceiveAd:(GADBannerView *)view {
    if (adLoaded) return;
    
    adLoaded = YES;
    isViewDidLoad = NO;
}


- (void)bannerView:(nonnull GADBannerView *)bannerView didFailToReceiveAdWithError:(nonnull NSError *)error {
    adLoaded = NO;
    
    NSLog(@"ads error %@", error.localizedDescription);
}
    
- (BOOL)isAdLoaded {
    return adLoaded;
}
    
- (IBAction)doDismissRate:(id)sender {
    [RateHelper dontRateToday];
    viewRate.superview.hidden = true;
}
    
- (IBAction)doRateNow:(id)sender {
    [RateHelper rateNow:^{
        self->viewRate.superview.hidden = true;
    }];
}
    
@end
