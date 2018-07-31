# 主要功能
防止按钮重复点击

# 实现原理
# 第一步：交换方法实现
static dispatch_once_t onceToken;
    //保证只运行一次
    dispatch_once(&onceToken, ^{
        //交换方法
        Method sendAction = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method sg_sendAction = class_getInstanceMethod(self, @selector(sg_sendAction:to:forEvent:));
        method_exchangeImplementations(sendAction, sg_sendAction);
    });
# 第二步：关联判断属性
-(NSInteger)targetTime{
    return [objc_getAssociatedObject(self, "targetTime") integerValue];
}

-(void)setTargetTime:(NSInteger)targetTime{
    objc_setAssociatedObject(self, "targetTime", @(targetTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
# 第三步：实现交换函数
-(void)sg_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.targetTime==0) {//判断是否执行点击方法
        self.targetTime = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//3秒钟后改变执行条件
            self.targetTime = 0 ;
        });
        [self sg_sendAction:action to:target forEvent:event];
    }else{
        NSLog(@"不可多次重复点击");
    }
}
   

