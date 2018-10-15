# DMRouter
iOS路由模块
#### push使用方法

``` 
[[DMSASRouter sharedDMSASRouter] openURL:DMModule1(DMPPJIJinModule)  className:@"SecondViewController" options:@{@"NavTitle":@"第二个页"}];
```
#### present使用方法

```
 [[DMSASRouter sharedDMSASRouter] openURL:DMModule2(DMPPJIJinModule, DMRouterActionPresent) className:@"ThreeViewController" options:nil];
```

