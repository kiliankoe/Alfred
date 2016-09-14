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
        var item = Item(title: "\(name) (\(version))", subtitle: summary, arg: .simple(link1))
        item.alt = Modifier(arg: link2, subtitle: "Open documentation!")
        return item
    }
}

let res = Response()

let repos = (0..<100).map { _ in Repo() }

res.addItems(repos)
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
let item = Item(title: "a cool title", subtitle: "a cool subtitle", arg: .simple("https://www.example.com"))
```

Then add the items to your response object:

```Swift
res.addItem(item) // one item

res.addItems(items) // array of items
```

If all output items are in the response instance, just print it out, so that Alfred is showing the results:

```Swift
print(res.toJSON())
```

That's all!

## Complex Arguments ##

Complex arguments might be a thing you will never use. It is possible to extend not only one output of your script but also multiple variables. This can be very useful!
To create complex arguments, just set the arg property of the Item to .complex(...) and inject an instance of ComplexArgument. ComplexArgument also has the 'simple' argument in it which you can set on the 'argument' property. But you also have the possibility to set a variety of custom variables. Just set a dictionary of your values to the variables property of the ComplexArgument instance.
In Alfred you can then use the values with the ```{var:varName}``` writing style. varName would be the key in the dictionary and the resulting output would be the value in the dictionary.

## Build it ##

This library needs Swift 3, so be sure to have the latest swift version installed. Type in 'swift build -c release' to build your package in release mode (which will make it a bit faster due to optimizations). This creates a binary file in the ./.build/release/ folder with the name of your Package. Copy this to the Alfred workflow folder and start it by calling it in the script filter over a bash script.

## License ##

This project is under MIT license, see ./LICENSE for more informations.
