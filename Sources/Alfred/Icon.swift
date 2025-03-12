import Foundation

/// The icon displayed in the result row.
///
/// Path is relative to the workflow's root folder:
///  - `path = "./custom_icon.png"`
///
/// The optional type key alters this behaviour. Setting it to fileicon will tell Alfred to get the file icon for the specified path.
///  - `type = .fileicon`, `path = "~/Desktop"`
///
/// filetype is similar but takes a file UTI (Uniform Type Identifier) as the path.
///  - `type = .filetype`, `path = "com.apple.rtfd"`
///
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

// MARK: - ExpressibleByStringLiteral
extension Icon: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = Icon(path: value)
    }
}
