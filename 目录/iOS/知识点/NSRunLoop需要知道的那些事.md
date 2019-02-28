NSRunLoop需要知道的那些事
======================
#### 脑图分析
![](https://my.mindnode.com/hxzNSMNDgzVaRnussfAWZJ38upK49erptypsmzpx#131.5,40.7,2)

#### 什么是RunLoop？
RunLoop又称运行循环，有没有想过你在使用微信的时候，不管我们什么时候点击微信内的操作按钮，微信都能及时的给予我们反馈，就像有一个人，一直注意着我们的一举一动。言归正传，正是有RunLoop的存在，微信才可以一直运行，不被系统杀死.

#### RunLoop干了哪些事？
- 保证程序一直运行并监听用户输入（主运行循环）
- 事件处理
- 调用解耦
- 节省CPU（有事干事，没事休眠）

#### RunLoop与GCD的关系
下面这段伪代码出自[这里](https://www.jianshu.com/p/296f182c8faa)
`````````````
//首先do..while循环不能是一个死循环,所以在这里设置一个过期时间
//这件事是GCD干的，用来检测do..while循环跑了多久
SetupThisRunLoopRunTimeoutTimer();

//开始跑循环
do{
    //告诉observer我要跑timer了
    __CFRunLoopDoObservers(kCFRunLoopBeforeTimers);
    //告诉observer我要跑source了
    __CFRunLoopDoObservers(kCFRunLoopBeforeSources);

    __CFRunLoopDoBlocks();
    //程序跑到这里会查询Source0有什么消息
    __CFRunLoopDoSource0();

    //询问GCD你有没有存在主线程的东西需要我帮你调
    CheckIfExistMessagesInMainDispatchQueue();  //GCD

    //告诉observer我要睡了，RunLoop进入到挂起状态
    __CFRunLoopDoObservers(kCFRunLoopBeforeWaiting);

    //进入trap状态，程序跑到这里就卡在这不动了，等待被某个Port唤醒
    var wakeUpPort = SleepAndWaitForWakingUpPorts();

    //被唤醒后，告诉observer我被唤醒了
    __CFRunLoopDoObservers(kCFRunLoopAfterWaiting);

    //假如是被timer唤醒的
    if(wakeUpPort == timerPort){
        //就去循环遍历和timer有关的回调
        __CFRunLoopDoTimers();
    }else if(wakeUpPort == mainDispatchQueuePort) {
        //如果是主线程的GCD把我唤醒的，那RunLoop就知道GCD要让它做事了，然后就取调GCD的这些事件
        __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE_()
    }else {
          //如果都不是，就是Source1，Source1是基于Port事件的，比如网络某个端口来数据了，就会把RunLoop唤醒，去对来的数据进行处理
          __CFRunLoopDoSource1();
    }
    __CFRunLoopDoBlocks();
}while(!stop && !timeout);
//判断条件：有没有被外部干掉 && 到了过期时间
//如果过期时间不手动进行设置的话，默认值是一个很大的值，可能是Int_Max
`````````````

#### TableView延长加载图片的巧妙实现

    //在cell里面把设置图片的事情在NSDefaultRunloopMode里面去做。
    //当主线程的tableview不再滑动的时候就会去设置图片
    UIImage *dowloadImage = ...;
    [self.iconImageView performSelector:@selector(setImage:) withObject:dowloadImage afterDelay:0 inModes:@[NSDefaultRunloopMode]];