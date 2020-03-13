# Alfred

Build awesome Alfred workflows with Swift! Previously known as *Benchr267/swiftalfred*, this project now lives on as *Alfred* here.

## Example

```swift
import Alfred

struct Repo: ItemRepresentable {
    var name = "a name!"
    var version = "12.3"
    var link1 = "https://www.example.com"
    var link2 = "https://www.example.com/doc"
    var summary = "This is soooo cool!"

    var item: Item {
        var item = Item(title: "\(name) (\(version))", subtitle: summary, arg: .simple(link1))
        item.alt = ModifierAction(arg: .simple(link2), subtitle: "Open documentation!")
        return item
    }
}
let repos = (0..<100).map { _ in Repo() }
let res = Response(items: repos)

let output = try res.output()
print(output)
```

## Installation

Add the following package to your `Package.swift`'s list of dependencies:

```swift
.package(url: "https://github.com/kiliankoe/alfred.git", from: "<#latest#>")
```

## License

This project is under MIT license, see LICENSE for more information.
