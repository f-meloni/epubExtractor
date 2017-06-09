# EpubExstractor
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-red.svg)
[![Version](https://img.shields.io/cocoapods/v/EpubExstractor.svg?style=flat)](http://cocoapods.org/pods/EpubExstractor)
[![License](https://img.shields.io/cocoapods/l/EpubExstractor.svg?style=flat)](http://cocoapods.org/pods/EpubExstractor)
[![Platform](https://img.shields.io/cocoapods/p/EpubExstractor.svg?style=flat)](http://cocoapods.org/pods/EpubExstractor)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift: 3.0+
- XCode: 8.0+

## Installation

EpubExstractor is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EpubExstractor"
```

## Usage
```swift
let epubExtractor = EPubExtractor()
epubExtractor.delegate = self
let destinationURL = //Destintion URL
epubExtractor.extractEpub(epubURL: epubURL, destinationFolder: destinationURL)
```

## EpubExtractorDelegate
```swift
public protocol EpubExtractorDelegate {
    func epubExactorDidExtractEpub(_ epub: Epub)
    func epubExtractorDidFail(error: Error?)
}
```

## Author

f-meloni, franco.meloni91@gmail.com

## License

EpubExstractor is available under the MIT license. See the LICENSE file for more info.
