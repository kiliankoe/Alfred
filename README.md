# swiftalfred
Build awesome Alfred workflows with Swift!

## Example

```Swift
struct Repo: Itemable {
    var name = "a name!"
    var version = "12.3"
    var link1 = "https://www.example.com"
    var link2 = "https://www.example.com/doc"
    var summary = "This is soooo cool!"

    var item: Item {
        var item = Item(title: "\(name) (\(version))", subtitle: summary, arg: .simple(link1))
        item.alt = Modifier(arg: .simple(link2), subtitle: "Open documentation!")
        return item
    }
}

let res = Response()

let repos = (0..<100).map { _ in Repo() }

res.add(items: repos)
let json = res.toJSON()
print(json)
```

## Installation

Add the following package to your `Package.swift`'s list of dependencies:

```swift
.Package(url: "https://github.com/BenchR267/swiftalfred.git", majorVersion: 1, minor: 2)
```

See below for more detailed instructions on getting started.

## How to use it

This library can only be used with the Swift Package Manager. The easiest way to start a new project is via the following commands.

```sh
$ mkdir YOUR_PROJECT_NAME
$ cd YOUR_PROJECT_NAME
$ swift package init --type executable
```

Once you do, the following directory structure will be created for you:

```
.
├── Package.swift
├── Sources
│   └── main.swift
└── Tests
```

Now open `Package.swift` and add a `dependencies` section starting with swiftalfred.

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .Package(url: "https://github.com/BenchR267/swiftalfred.git", majorVersion: 1, minor: 2)
    ]
)
```

Now go ahead and open `main.swift`. To hand over a list of output items to Alfred at some point, create a `Response` object.

```Swift
let res = Response()
```

Add some `Item`s to it. You can use your own items if they conform to `Itemable` or you just use the plain `Item` type:

```Swift
let myitem = Item(title: "a cool title", subtitle: "a cool subtitle", arg: .simple("https://www.example.com"))
```

Then add the items to your response object:

```Swift
res.add(item: myitem) // one item

res.add(items: myitems) // array of items
```

If all output items are in the response instance, just print it out, so that Alfred is showing the results:

```Swift
print(res.toJSON())
```

That's all! ✨

## Complex Arguments

Complex arguments might be a thing you will never use. It is possible to extend not only one output of your script but also multiple variables. This can be very useful!
To create complex arguments, just set the arg property of the Item to .complex(...) and inject an instance of ComplexArgument. ComplexArgument also has the 'simple' argument in it which you can set on the 'argument' property. But you also have the possibility to set a variety of custom variables. Just set a dictionary of your values to the variables property of the ComplexArgument instance.
In Alfred you can then use the values with the ```{var:varName}``` writing style. varName would be the key in the dictionary and the resulting output would be the value in the dictionary.

## Build it

This library needs Swift 3, so be sure to have the latest swift version installed. Type in `swift build -c release` to build your package in release mode (which will make it a bit faster due to optimizations). This creates a binary file in the `.build/release/` folder with the name of your Package. Copy this to the Alfred workflow folder and start it by calling it in the script filter over a bash script or directly.

## License

This project is under MIT license, see LICENSE for more information.
