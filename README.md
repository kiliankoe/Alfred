# swiftalfred
Build awesome Alfred workflows with Swift!

## Example ##

```Swift
struct Repo: Itemable {
    var name = "a name!"
    var version = "12.3"
    var link1 = "https://www.example.com"
    var link2 = "https://www.example.com/doc"
    var summary = "This is soooo cool!"
    
    var item: Item {
        var item = Item(title: "\(name) (\(version))", subtitle: summary, arg: link1)
        item.alt = Modifier(arg: link2, subtitle: "Open documentation!")
        return item
    }
}

let res = Response()

let repos = (0..<100).map { _ in Repo() }

repos.forEach(res.addItem)
let json = res.toJSON()
print(json)
```

## How to use it ##

This library can only be used with the Swift Package Manager. So create a new folder, create a Package.swift inside and another folder inside called src/.
Then create a main.swift file in the src/ folder. The Package.swift should look like this:

```Swift
import PackageDescription

let package = Package(
    name: "YOURPACKAGENAME",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/BenchR267/swiftalfred.git", majorVersion: 1)
    ]
)
```

Change YOURPACKAGENAME to a name that fits your needs.
Then write your workflow in the main.swift file. For output, create a response instance:

```Swift
let res = Response()
```

and add some Items to it. You can use your own items if they conform to Itemable or you just use the plain Item type:

```Swift
let item = Item(title: "a cool title", subtitle: "a cool subtitle", arg: "https://www.example.com")
```

Then add the items to your response object:

```Swift
res.addItem(item) // one item

items.forEach(res.addItem) // array of items
```

If all output items are in the response instance, just print it out, so that Alfred is showing the results:

```Swift
print(res.toJSON())
```

That's all!

## Build it ##

This library needs Swift 3, so be sure to have the latest swift version installed. Type in 'swift build -c release' to build your package in release mode (which will make it a bit faster due to optimizations). This creates a binary file in the ./.build/release/ folder with the name of your Package. Copy this to the Alfred workflow folder and start it by calling it in the script filter over a bash script.

## License ##

This project is under MIT license, see ./LICENSE for more informations.