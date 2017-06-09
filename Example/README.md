# EpubExtractor
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-red.svg)
[![Version](https://img.shields.io/cocoapods/v/EpubExtractor.svg?style=flat)](http://cocoapods.org/pods/EpubExtractor)
[![License](https://img.shields.io/cocoapods/l/EpubExtractor.svg?style=flat)](http://cocoapods.org/pods/EpubExtractor)
[![Platform](https://img.shields.io/cocoapods/p/EpubExtractor.svg?style=flat)](http://cocoapods.org/pods/EpubExtractor)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift: 3.0+
- XCode: 8.0+

## Installation

EpubExtractor is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EpubExtractor"
```

## Usage
```swift
let epubExtractor = EPubExtractor()
epubExtractor.delegate = self
let destinationURL = //Destintion URL
epubExtractor.extractEpub(epubURL: //Epub URL, destinationFolder: destinationURL)
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

EpubExtractor is available under the MIT license. See the LICENSE file for more info.
