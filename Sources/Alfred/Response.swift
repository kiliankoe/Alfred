import Foundation

public struct Response: Encodable {
    var items: [Item]

    public init(items: [Item] = []) {
        self.items = items
    }

    public mutating func append(item: ItemRepresentable) {
        items.append(item.item)
    }

    public mutating func append(contentsOf items: [ItemRepresentable]) {
        self.items.append(contentsOf: items.map { $0.item })
    }

    public func output() throws -> String {
        let json = try Self.encoder.encode(self)
        return String(data: json, encoding: .utf8)!
    }

    static var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
}
