import Foundation

public struct ModifierAction: Equatable {
    var arg: Argument?
    var subtitle: String?
    var icon: Icon?
    var variables: [String: String] = [:]
    public var valid: Bool

    public init(
        arg: Argument? = nil,
        subtitle: String? = nil,
        icon: Icon? = nil,
        valid: Bool = true,
        variables: [String: String] = [:]
    ) {
        self.arg = arg
        self.subtitle = subtitle
        self.icon = icon
        self.valid = valid
        self.variables = variables
    }
}

// MARK: - Encodable
extension ModifierAction: Encodable {

    private enum CodingKeys: String, CodingKey {
        case arg
        case subtitle
        case valid
        case variables
        case icon
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encodeIfNotNil(arg, forKey: .arg)
        try container.encodeIfNotNil(icon, forKey: .icon)
        try container.encodeIfNotEmpty(variables, forKey: .variables)

        if !valid {
            try container.encode(valid, forKey: .valid)
        }
    }
}
