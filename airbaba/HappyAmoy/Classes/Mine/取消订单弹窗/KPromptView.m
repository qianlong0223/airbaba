//
//  KPromptView.m
//  云阙普惠
//
//  Created by a on 2019/3/28.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "KPromptView.h"
#import "PromptCell.h"
#import <Masonry.h>
//屏幕尺寸
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//一个默认的坐标
#define HHframe  CGRectMake(0, 0, SCREEN_WIDTH-20, 50)
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface KPromptView()<UITableViewDelegate,UITableViewDataSource,promptCellDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong) UIView * promptView;
//@property (nonatomic ,strong) NSIndexPath *lastPath;//单选记录row
@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行

@property(nonatomic,copy)NSString * cellStr;//单元格内容

@end
@implementation KPromptView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title cellArray:(NSArray *)cellArr indexPath:(NSIndexPath*)indexPath{
    
    if (self =[super initWithFrame:frame]) {
        self.cellArr = cellArr;
        self.indexPath=indexPath;
        self.cellStr=@"";
        self.title=title;
        self.backgroundColor = [[UIColor blackColor ]colorWithAlphaComponent:0.4];
        UIView * promptView = [UIView new];
        
        [self addSubview:promptView];
        self.promptView = promptView;
        
        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(self);
            make.height.mas_equalTo(SCREEN_HEIGHT*2/3);
            
            
        }];
        
        
        UILabel * titleLab= [[UILabel alloc]initWithFrame:HHframe];
        titleLab.backgroundColor = [UIColor whiteColor];
        titleLab.font =TextFont(17);
        titleLab.textAlignment=NSTextAlignmentCenter;
        titleLab.text = title;
        titleLab.textColor = ColorWithHexString(@"#222222");
        [promptView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.mas_equalTo(promptView);
            make.height.mas_equalTo(50);
            
        }];
        UIView * tipView = [[UIView alloc]init];
        tipView.backgroundColor = [UIColor whiteColor];
        
        [promptView addSubview:tipView];
        [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLab.mas_bottom);
                make.left.right.mas_equalTo(promptView);
                make.height.mas_equalTo(120);
            
        }];
        UILabel * tipLable= [[UILabel alloc]initWithFrame:HHframe];
        tipLable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tipLable.font =[UIFont boldSystemFontOfSize:14];
        tipLable.textAlignment = 0;
        tipLable.numberOfLines = 0;
        tipLable.lineBreakMode = NSLineBreakByWordWrapping;
        tipLable.text = @"   温馨提示\n   1.限时特价、预约资格等购买优惠可能一并取消\n   2.支付券不予返还；支付优惠一并取消\n   3.订单一旦取消，无法恢复";
        tipLable.textColor = ColorWithHexString(@"#999999");
        ViewRadius(tipLable, 8.f);
        [tipView addSubview:tipLable];
        
        [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //            make.top.left.right.mas_equalTo(promptView);
                make.top.mas_equalTo(tipView.mas_top).offset(10);
                make.left.mas_equalTo(tipView.mas_left).offset(10);
                make.right.mas_equalTo(tipView.mas_right).offset(-10);
                make.bottom.mas_equalTo(tipView.mas_bottom).offset(-10);
            
        }];
        UILabel * reasonLab= [[UILabel alloc]initWithFrame:HHframe];
        reasonLab.backgroundColor = [UIColor whiteColor];
        reasonLab.font =[UIFont boldSystemFontOfSize:15];
        reasonLab.textAlignment = 0;
        reasonLab.text = @"     请选择订单取消的原因";
        reasonLab.textColor = ColorWithHexString(@"#151515");
        [promptView addSubview:reasonLab];
        [reasonLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(tipView.mas_bottom).offset(0);
            make.left.mas_equalTo(promptView);
            make.right.mas_equalTo(promptView);
            make.height.mas_equalTo(30);
            
        }];
       
        
        UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.backgroundColor = QHMainColor;
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        [promptView addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(promptView);
            make.height.mas_equalTo(50);
            
            
            
        }];
        
        
        
        
        
        UITableView * tableView = [[UITableView alloc]initWithFrame:HHframe style:UITableViewStylePlain];
        tableView.delegate =self;
        tableView.dataSource=self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [promptView addSubview:tableView];
        self.tableView = tableView;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
          
            make.top.mas_equalTo(reasonLab.mas_bottom);
            make.left.right.mas_equalTo(promptView);
            make.bottom.mas_equalTo(submitBtn.mas_top).offset(0);
            
            
            
        }];
        [tableView registerNib:[UINib nibWithNibName:@"PromptCell" bundle:nil] forCellReuseIdentifier:@"PromptCell"];
        
        tableView.tableFooterView= [[UIView alloc]initWithFrame:CGRectZero];
        
        
        
        
        
    }
    
    return self;
    
  
    
}
#pragma mark ----提交

-(void)submitAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(kPromptView:cellStr:)]) {
        [_delegate kPromptView:self cellStr:self.cellStr];
    }
    
    
    
    
    self.hidden =YES;
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromptCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PromptCell"];
    if (!cell) {
        cell = [[PromptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PromptCell"];
        
    }
    cell.selectedIndexPath = indexPath;
    
    [cell.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
    
    //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
    if (_selectedIndexPath == indexPath) {
        [cell.selectBtn setImage:[UIImage imageNamed:@"ic_selected_nor"] forState:UIControlStateNormal];
        
    }else {
        [cell.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];

    }
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    cell.titleLab.text=self.cellArr[indexPath.row];
    
    return cell;
}
-(void)selectRowStr:(NSString *)cellStr indexPath:(NSIndexPath *)selectedIndexPath
{
    self.cellStr=cellStr;
    
    PromptCell *celled = [_tableView cellForRowAtIndexPath:_selectedIndexPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    [celled.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
    //记录当前选中的位置索引
    _selectedIndexPath = selectedIndexPath;
    //当前选择的打勾
    PromptCell *cell = [_tableView cellForRowAtIndexPath:selectedIndexPath];
    [cell.selectBtn setImage:[UIImage imageNamed:@"ic_selected_nor"] forState:UIControlStateNormal];
    
    
    
    
    
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO] ;
//
//        NSInteger newRow = [indexPath row];
//        NSInteger oldRow = (self .lastPath !=nil)?[self.lastPath row]:-1;
//        if (newRow != oldRow) {
//            PromptCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
//            [newCell.selectBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal] ;
//
//            PromptCell *oldCell = [tableView cellForRowAtIndexPath:indexPath];
//            [oldCell.selectBtn setImage:[UIImage imageNamed:@"ic_selected_nor"] forState:UIControlStateNormal] ;
//
//            self .lastPath = indexPath;
//        }
//
//
//    [tableView reloadData] ;
//}
// 点击提示框视图以外的其他地方时隐藏弹框
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.promptView.layer convertPoint:point fromLayer:self.layer];
    if (![self.promptView.layer containsPoint:point]) {
        self.hidden = YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end
