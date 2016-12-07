# VIPERS-Converter

[![CI Status](http://img.shields.io/travis/Jan Bartel/VIPERS-Converter.svg?style=flat)](https://travis-ci.org/Jan Bartel/VIPERS-Converter)
[![Version](https://img.shields.io/cocoapods/v/VIPERS-Converter.svg?style=flat)](http://cocoapods.org/pods/VIPERS-Converter)
[![License](https://img.shields.io/cocoapods/l/VIPERS-Converter.svg?style=flat)](http://cocoapods.org/pods/VIPERS-Converter)
[![Platform](https://img.shields.io/cocoapods/p/VIPERS-Converter.svg?style=flat)](http://cocoapods.org/pods/VIPERS-Converter)

Converter implementation used by the iOS application framework 'VIPERS'.

A converter is an object responsible for converting an element of a specific type into an other element of a type. It supports some methods to check its responsibility for a specific output type and a specific input object (e.g. can i convert input x to type y).

The converter pattern is used in many VIPERS classes (e.g. Router, Wireframe)

A general converter implements the ConverterProtocol

```swift

public protocol ConverterProtocol{
func isResponibleForOutputType<T>(_ type:T.Type) -> Bool
func isResponsible(_ input:Any) throws -> Bool
func convert(_ input: Any) throws -> Any
}

```

There is also a dereived protocol for a converter for specific in and output types

```swift
public protocol TypedConverterProtocol : ConverterProtocol{

associatedtype ConverterOutputType
associatedtype ConverterInputType

func isResponibleForOutputType<T>(_ type:T.Type) -> Bool

func isResponsible(_ input:ConverterInputType) throws -> Bool

func convert(_ input: ConverterInputType) throws -> ConverterOutputType
}

```

A simple implementation of a TypedConverter is shown below:
```swift

class DateToStringConverter : TypedConverterProtocol{

typealias ConverterOutputType = String
typealias ConverterInputType = Date

func isResponsible(_ input:Date) throws -> Bool{
return true
}

func convert(_ input: Date) throws -> String{
let formatter = DateFormatter()
return formatter.string(from: input)
}
}

```

There is also a implementation (in the VIPERS-Converter Pod) of a ComposedConverter which aggregates different converters and converts an input with the first possible contained converter

```swift

let composedConverter = ComposedConverter()

let dateConverter = DateToStringConverter()
composedConverter.addConverter(dateConverter)

//add some other converters here

let dateConvertedToString : String = try composedConverter.convert(Date())
print(dateConvertedToString)


```


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

VIPERS-Converter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "VIPERS-Converter"
```

## Author

Jan Bartel, barteljan@yahoo.de

## License

VIPERS-Converter is available under the MIT license. See the LICENSE file for more info.
