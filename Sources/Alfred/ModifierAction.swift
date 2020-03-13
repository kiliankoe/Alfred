public struct ModifierAction: Encodable, Equatable {
    var arg: Argument
    var subtitle: String?
    public var valid: Bool

    public init(arg: Argument, subtitle: String? = nil, valid: Bool = true) {
        self.arg = arg
        self.subtitle = subtitle
        self.valid = valid
    }

    private enum CodingKeys: String, CodingKey {
        case arg
        case subtitle
        case valid
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(arg, forKey: .arg)
        try container.encode(subtitle, forKey: .subtitle)
        if !valid {
            try container.encode(valid, forKey: .valid)
        }
    }
}
