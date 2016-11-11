import Foundation

protocol JSONable {
    var json: [String: Any] { get }
}

public class Response: JSONable {
    private var items = [Item]()

    public init() {}

    public func add(item: Itemable) {
        items.append(item.item)
    }

    public func add<T: Itemable>(items: [T]) {
      items.forEach(add)
    }

    var json: [String: Any] {
        return ["items": items.map { $0.json } ]
    }

    public func toJSON() -> String {
        return jsonString(object: json)
    }
}

func jsonString(object: Any) -> String {
    guard let d = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
        return ""
    }
    return String(data: d, encoding: String.Encoding.utf8) ?? ""
}
