# DDUserDefaultManager

![](https://img.shields.io/badge/CocoaPods-supported-brightgreen) ![](https://img.shields.io/badge/Swift-5.0-brightgreen) ![](https://img.shields.io/badge/License-MIT-brightgreen) ![](https://img.shields.io/badge/version-iOS12.0-brightgreen)

### [中文文档](https://dongge.org/blog/1289.html)

iOS UserDefault data management, iOS UserDefault数据管理

## install

cocoapods

```ruby
pod 'DDUserDefaultManager'
```

### Use

```swift
DDUserDefaultManager.shared.start()
```

If you want to control VC navigation yourself, you can use `DDUserDefaultVC`.

```
let vc = DDUserDefaultVC()
self.navigationController?.pushViewController(vc, animated: true)
```

## Preview

|File List|File Type Icon|
|----|----|
|![](./preview/demo2.png)|![](./preview/demo1.png)|

Function example

![](./preview/preview.gif)

## License

The project is based on the MIT License
