public protocol ItemRepresentable: Encodable {
    var item: Item { get }
}

public struct Item: ItemRepresentable {
    public var item: Item { self }

    public enum ItemType: String, Encodable {
        case file
        case skipCheck = "file:skipcheck"
    }

    public init(
        uid: String? = nil,
        title: String,
        subtitle: String,
        arg: Argument? = nil,
        icon: Icon? = nil,
        valid: Bool = true,
        autocomplete: String? = nil,
        type: Item.ItemType? = nil,
        cmd: Modifier? = nil,
        alt: Modifier? = nil
    ) {
        self.uid = uid
        self.title = title
        self.subtitle = subtitle
        self.arg = arg
        self.icon = icon
        self.valid = valid
        self.autocomplete = autocomplete
        self.type = type
        self.cmd = cmd
        self.alt = alt
    }

    public var uid: String?
    public var title: String
    public var subtitle: String
    public var arg: Argument?
    public var icon: Icon?
    public var valid: Bool
    public var autocomplete: String?
    public var type: ItemType?
    public var cmd: Modifier?
    public var alt: Modifier?

    public func uid(_ uid: String) -> Item {
        var item = self
        item.uid = uid
        return item
    }

    public func arg(_ arg: Argument) -> Item {
        var item = self
        item.arg = arg
        return item
    }

    public func icon(_ icon: Icon) -> Item {
        var item = self
        item.icon = icon
        return item
    }

    public func valid(_ valid: Bool) -> Item {
        var item = self
        item.valid = valid
        return item
    }

    public func autocomplete(_ autocomplete: String) -> Item {
        var item = self
        item.autocomplete = autocomplete
        return item
    }

    public func type(_ type: ItemType) -> Item {
        var item = self
        item.type = type
        return item
    }

    public func cmd(_ cmd: Modifier) -> Item {
        var item = self
        item.cmd = cmd
        return item
    }

    public func alt(_ alt: Modifier) -> Item {
        var item = self
        item.alt = alt
        return item
    }

    private enum CodingKeys: String, CodingKey {
        case uid, title, subtitle, arg, icon,
            valid, autocomplete, type, mod
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let uid = uid {
            try container.encode(uid, forKey: .uid)
        }
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        if let arg = arg {
            try container.encode(arg, forKey: .arg)
        }
        if let icon = icon {
            try container.encode(icon, forKey: .icon)
        }
        if !valid {
            try container.encode(valid, forKey: .valid)
        }
        if let autocomplete = autocomplete {
            try container.encode(autocomplete, forKey: .autocomplete)
        }
        if let type = type {
            try container.encode(type, forKey: .type)
        }

        struct ModifierWrapper: Encodable {
            let cmd: Modifier?
            let alt: Modifier?
        }
        if cmd != nil || alt != nil {
            let wrapper = ModifierWrapper(cmd: cmd, alt: alt)
            try container.encode(wrapper, forKey: .mod)
        }
    }
}
