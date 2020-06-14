# RxSupport

[![CI Status](https://img.shields.io/travis/outofcoding/RxSupport.svg?style=flat)](https://travis-ci.org/outofcoding/RxSupport)
[![Version](https://img.shields.io/cocoapods/v/RxSupport.svg?style=flat)](https://cocoapods.org/pods/RxSupport)
[![License](https://img.shields.io/cocoapods/l/RxSupport.svg?style=flat)](https://cocoapods.org/pods/RxSupport)
[![Platform](https://img.shields.io/cocoapods/p/RxSupport.svg?style=flat)](https://cocoapods.org/pods/RxSupport)

## Installation

RxSupport is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxSupport'
```

## Requirements
- Swift 4

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### ObservableType.Support
Unwrapping for Observable.Element is optional type
```swift
// notNil
let optionalValue1: String? = "not nil"
Observable.just(optionalValue1)
    .notNil()
    .subscribe(weak: self) { (self, value) in
        print("string = \(value)")
    }
.disposed(by: disposeBag)

// or
let optionalValue2: String? = nil
Observable.just(optionalValue2)
    .or("null value")
    .subscribe(weak: self) { (self, value) in
        print("string = \(value)")
    }
.disposed(by: disposeBag)
```

### ObservableType.Weak
weak self make and self is nil not work closure. your type saving.
flatMap, flatMapFirst, flatMapLatest, do, map, subscribe
```swift
// Before
Observable.just(1)
    .map { [weak self] number -> String? in
        if let self = self {
            return "\(self.text) \(number)"
        } else {
            return nil
        }
    }
    .notNil()
    .subscribe(onNext: { [weak self] value in
        guard let self = self else { return }
        print("\(self.format)\(value)")
    })
    .disposed(by: disposeBag)

// After
Observable.just(2)
    .map(weak: self) { (self, number) -> String in
        "\(self.text) \(number)"
    }
    .subscribe(weak: self) { (self, value) in
        print("\(self.format)\(value)")
    }
    .disposed(by: disposeBag)
```

## Author

outofcoding, outofcoding@gmail.com

## License

RxSupport is available under the MIT license. See the LICENSE file for more info.
