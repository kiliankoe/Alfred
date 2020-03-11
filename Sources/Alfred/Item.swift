public protocol Itemable {
    var item: Item { get }
}

public struct Item: JSONable, Itemable {

    public enum ItemType {
        case file, skipCheck

        var key: String {
            switch self {
            case .file: return "file"
            case .skipCheck: return "file:skipcheck"
            }
        }
    }

    public init(title: String, subtitle: String, arg: Argument? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.arg = arg
    }

    public var uid: String?
    public var title: String
    public var subtitle: String
    public var arg: Argument?
    public var icon: Icon?
    public var valid = true
    public var autocomplete: String?
    public var type: Item.ItemType?
    public var cmd: Modifier?
    public var alt: Modifier?

    var json: [String : Any] {
        var j = [String: Any]()
        j["uid"] = uid
        j["title"] = title
        j["subtitle"] = subtitle
        j["arg"] = arg?.json
        j["icon"] = icon?.json
        if !valid { j["valid"] = valid }
        j["autocomplete"] = autocomplete
        j["type"] = type?.key

        var mod: [String: Any]?
        if cmd != nil || alt != nil { mod = [String: Any]() }
        mod?["cmd"] = cmd?.json
        mod?["alt"] = alt?.json
        j["mod"] = mod

        return j
    }

    public var item: Item {
        return self
    }
}
