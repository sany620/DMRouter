# DMRouter
iOS路由模块
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