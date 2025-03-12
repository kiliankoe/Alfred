import Foundation

public struct Text: Encodable {

    /// Defines the text the user will get when copying the selected result row with ⌘C or
    var copy: String?

    /// Defines the text the user will displaying large type with ⌘L
    var largetype: String?

    public init(
        copy: String? = nil,
        largetype: String? = nil
    ) {
        self.copy = copy
        self.largetype = largetype
    }
}
