public struct Icon: Codable, Equatable {
    public enum IconType: String, Codable {
        case fileicon, filetype
    }

    var type: IconType?
    var path: String

    public init(path: String, type: IconType? = nil) {
        self.path = path
        self.type = type
    }
}

extension Icon: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = Icon(path: value)
    }
}
