# 主要功能
防止按钮重复点击

# 实现原理
第一步：使用run time method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2) 交换UIButtonsendAction:to:forEvent:方法实现
第二部：使用run time objc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)与objc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,
                         id _Nullable value, objc_AssociationPolicy policy)关联一个值做为防止重复点击的条件
第三步：使用gcd的dispatch_after函数做一个延时操作，改变关联属性值；
   

