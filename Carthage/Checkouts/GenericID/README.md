> This project is currently in beta and APIs are subject to change.

# GenericID

[![Build Status](https://travis-ci.org/ddddxxx/GenericID.svg?branch=master)](https://travis-ci.org/ddddxxx/GenericID)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)
![supports](https://img.shields.io/badge/supports-Carthage%20%7C%20Swift_PM-brightgreen.svg)
![swift](https://img.shields.io/badge/swift-4.0-orange.svg)
[![codebeat badge](https://codebeat.co/badges/2bf7d7e0-2bfe-4280-bbb3-ed64566ddd10)](https://codebeat.co/projects/github-com-ddddxxx-genericid-master)

A Swift extension to use string-based API in a **type-safe** way.

All these fantastic API are compatible with traditional string-based API.

## Requirements

- macOS 10.10+ / iOS 8.0+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9+
- Swift 4.0+

## Type-safe `UserDefaults`

> You can use `NSUbiquitousKeyValueStore` with almost the same API.

### 1. Define your keys

```swift
extension UserDefaults.DefaultKeys {
    static let intKey   = Key<Int>("intKey")
    static let colorKey = Key<Color>("colorKey", transformer: .keyedArchive)
    static let pointKey = Key<CGPoint>("pointKey", transformer: .json)
}
```

### 2. Have fun!

```swift
let ud = UserDefaults.standard

// Get & Set
let value = ud[.intKey]
ud[.stringKey] = "foo"

// Modify
ud[.intKey] += 1
ud[.stringKey] += "bar"

// Typed array
ud[.stringArrayKey].contains("foo")
ud[.intArrayKey][0] += 1

// Work with NSKeyedArchiver
ud[.colorKey] = UIColor.orange
ud[.colorKey]?.redComponent

// Work with JSONEncoder
ud[.pointKey] = CGPoint(x: 1, y: 1)
ud[.pointKey]?.x += 1

// Modern Key-Value Observing
let observation = defaults.observe(.someKey, options: [.old, .new]) { (defaults, change) in
    print(change.newValue)
}

// KVO with deserializer
let observation = defaults.observe(.rectKey, options: [.old, .new]) { (defaults, change) in
    // deserialized automatically
    if let rect = change.newValue {
        someView.frame = rect
    }
}

// Register with serializer
ud.register(defaults: [
    .intKey: 42,
    .stringKey: "foo",
    .colorKey: UIColor.blue, // serialized automatically
    .pointKey: CGPoint(x: 1, y: 1),
])
```

### Default value

If associated type of a key conforms `DefaultConstructible`, a default value will be constructed for `nil` result.

```swift
public protocol DefaultConstructible {
    init()
}
```

Here's types that conforms `DefaultConstructible` and its default value:

| Type          | Default value |
|---------------|---------------|
| Bool          | `false`       |
| Int           | `0`           |
| Float/Double  | `0.0`         |
| String        | `""`          |
| Data          | [empty data]  |
| Array         | `[]`          |
| Dictionary    | `[:]`         |
| Optional      | `nil`         |

Note: `Optional` also conforms `DefaultConstructible`, therefore a key typed as `DefaultKey<Any?>` aka `DefaultKey<Optional<Any>>` will still returns `nil`, which is the result of default construction of `Optional`.

You can always associate an optional type if you want an optional value.

<!--### Observing-->

## Type-safe `UITableViewCell` / `UICollectionViewCell`

### 1. Define your reuse identifiers

```swift
extension UITableView.CellReuseIdentifiers {
    static let customCell : ID<MyCustomCell> = "CustomCellReuseIdentifier"
}
```

### 2. Register your cells

```swift
tableView.register(id: .customCell)
```

### 3. Dequeue your cells

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: .customCell, for: indexPath)
// Typed as MyCustomCell
```

### XIB-based cells

```swift
// That's it!
extension MyCustomCell: UINibFromTypeGettable

// Or, incase your nib name is not the same as class name
extension MyCustomCell: UINibGettable {
    static var nibName = "MyNibName"
}

// Then register
tableView.registerNib(id: .customCell)
```

## Type-safe Storyboard

### 1. Define your storyboards identifiers

```swift
extension UIStoryboard.Identifiers {
    static let customVC: ID<MyCustomViewController> = "CustomVCStoryboardIdentifier"
}
```

### 2. Use It!

```swift
// Also extend to get main storyboard
let sb = UIStoryboard.main()

let vc = sb.instantiateViewController(withIdentifier: .customVC)
// Typed as MyCustomViewController
```

## Type-safe Associated Object

```swift
// Define your associate keys
extension YourClass.AssociateKeys {
    static let someKey: Key<Int> = "someKey"
}

// Use it!
yourObject[.someKey] = 42
```

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add the project to your `Cartfile`:

```
github "ddddxxx/GenericID"
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the project to your `Package.swift` file:

```swift
let package = Package(
    dependencies: [
        .Package(url: "https://github.com/ddddxxx/GenericID")
    ]
)
```

## License

GenericID is available under the MIT license. See the [LICENSE file](LICENSE).
