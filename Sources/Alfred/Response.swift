import Foundation

public struct Response {

    private var data: ResponseModel

    public init(
        items: [Item] = [],
        variables: [String: String] = [:],
        skipknowledge: Bool = false,
        rerun: Int = 0,
        cache: Cache? = nil
    ) {
        data = ResponseModel(
            items: items,
            variables: variables,
            skipknowledge: skipknowledge,
            rerun: rerun,
            cache: cache
        )
    }

    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()

    public func output() throws -> String {
        let json = try Self.encoder.encode(data)
        return String(data: json, encoding: .utf8)!
    }
}

// MARK: - Convenient
extension Response  {
    public mutating func append(item: ItemRepresentable) {
        data.items.append(item.item)
    }

    public mutating func append(contentsOf items: [ItemRepresentable]) {
        data.items.append(contentsOf: items.map { $0.item })
    }

    public mutating func setVariable(_ value: String, for key: String) {
        data.variables[key] = value
    }

    public mutating func set(skipknowledge: Bool) {
        data.skipknowledge = skipknowledge
    }

    public mutating func set(rerun: Int) {
        data.rerun = rerun
    }

    public mutating func set(cache: Cache?) {
        data.cache = cache
    }
}
