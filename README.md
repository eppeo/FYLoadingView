加载loading视图，使用UIBezierPath进行绘制

![FYLoadingView](https://github.com/eppeo/FYLoadingView/blob/master/FYLoadingView.gif)

使用的时候，直接将FYLoadingView.swift文件拖入项目中，然后在viewDidLoad方法中调用
let loadingView = FYLoadingView(view: view)

为了避免被其他视图覆盖，应最后一个添加到视图上，初始化完成以后，不做addSubview处理，因为为了调取方便，内部已经添加

加载网络请求完成以后，要将视图移除，可以调用loadingView.dismiss()方法
