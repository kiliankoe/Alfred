public struct Icon: JSONable {
    public enum IconType: String {
        case fileicon, filetype
    }

    var type: Icon.IconType?
    var path: String

    public init(path: String, type: Icon.IconType? = nil) {
        self.path = path
        self.type = type
    }

    var json: [String : Any] {
        var j = [String: Any]()
        j["path"] = path
        j["type"] = type?.rawValue
        return j
    }
}
