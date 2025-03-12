import Foundation

public enum ItemType: String, Encodable {
    /// Alfred treats your result as a file on your system
    case file

    /// Use if you are certain the files you are returning exist
    case skipCheck = "file:skipcheck"
}
