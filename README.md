# DMRouter
iOS路由模块

#### Example

To run the example project, clone the repo, and run pod install from the Example directory first.

#### Installation

DMRouter is available through [CocoaPods](https://cocoapods.org/). To install it, simply add the following line to your Podfile:

```
pod 'DMRouter'
```

#### push使用方法

``` 
[RouterManager pushViewClassName:@"SecondViewController" options:@{@"NavTitle":@"第二个页"}];
```
#### present使用方法

```
 [RouterManager presentViewClassName:@"ThreeViewController" options:nil];
```

#### push或present带回调的使用方法

``` 
[RouterManager pushViewClassName:@"SecondViewController" options:@{@"NavTitle":@"第二个页"} completion:^(id result) {
        
}];
```
