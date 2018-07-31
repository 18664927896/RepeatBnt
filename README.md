# 主要功能
防止按钮重复点击

# 实现原理
## 第一步：交换方法实现
` static dispatch_once_t onceToken;<Br/>
    //保证只运行一次<Br/>
    dispatch_once(&onceToken, ^{<Br/>
        //交换方法<Br/>
       Method sendAction = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));<Br/>
        Method sg_sendAction = class_getInstanceMethod(self, @selector(sg_sendAction:to:forEvent:));<Br/>
        method_exchangeImplementations(sendAction, sg_sendAction);<Br/>
    });<Br/>``
## 第二步：关联判断属性
-(NSInteger)targetTime{<Br/>
    return [objc_getAssociatedObject(self, "targetTime") integerValue];<Br/>
}<Br/>

-(void)setTargetTime:(NSInteger)targetTime{<Br/>
    objc_setAssociatedObject(self, "targetTime", @(targetTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);<Br/>
}<Br/>
## 第三步：实现交换函数
-(void)sg_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{<Br/>
    if (self.targetTime==0) {//判断是否执行点击方法<Br/>
        self.targetTime = 1;<Br/>
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//3秒钟后改变执行条件<Br/>
            self.targetTime = 0 ;<Br/>
        });<Br/>
        [self sg_sendAction:action to:target forEvent:event];<Br/>
    }else{<Br/>
        NSLog(@"不可多次重复点击");<Br/>
    }<Br/>
}<Br/>
   

