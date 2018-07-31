# 主要功能
防止按钮重复点击

# 实现原理
# 第一步：交换方法实现
static dispatch_once_t onceToken;/n
    //保证只运行一次\n
    dispatch_once(&onceToken, ^{\n
        //交换方法\n
        Method sendAction = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));\n
        Method sg_sendAction = class_getInstanceMethod(self, @selector(sg_sendAction:to:forEvent:));\n
        method_exchangeImplementations(sendAction, sg_sendAction);\n
    });
# 第二步：关联判断属性
-(NSInteger)targetTime{\n
    return [objc_getAssociatedObject(self, "targetTime") integerValue];\n
}\n

-(void)setTargetTime:(NSInteger)targetTime{\n
    objc_setAssociatedObject(self, "targetTime", @(targetTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);\n
}
# 第三步：实现交换函数
-(void)sg_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{\n
    if (self.targetTime==0) {//判断是否执行点击方法\n
        self.targetTime = 1;\n
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//3秒钟后改变执行条件\n
            self.targetTime = 0 ;\n
        });\n
        [self sg_sendAction:action to:target forEvent:event];\n
    }else{\n
        NSLog(@"不可多次重复点击");\n
    }\n
}\n
   

