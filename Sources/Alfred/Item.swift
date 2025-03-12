import Foundation

/// `Item` describes a result row displayed in Alfred
/// See the [Script Filter JSON Format](https://www.alfredapp.com/help/workflows/inputs/script-filter/json/) for more info.
public struct Item {

    /// A unique identifier for the item.
    /// It allows Alfred to learn about the item for subsequent sorting and ordering of the user's actioned results.
    public var uid: String?

    /// The title displayed in the result row. There are no options for this element and it is essential that this element is populated.
    public var title: String

    /// The subtitle displayed in the result row
    public var subtitle: String

    /// The argument which is passed through the workflow to the connected output action
    public var arg: Argument?

    /// The icon displayed in the result row.
    public var icon: Icon?

    /// If an item is valid then Alfred will action it when the user presses return. If the item is not valid, Alfred will do nothing
    public var valid: Bool

    /// The match field enables you to define what Alfred matches against when the workflow is set to "Alfred Filters Results".
    /// If match is present, it fully replaces matching on the title property.
    ///
    /// The match field is always treated as case insensitive, and intelligently treated as diacritic insensitive.
    /// If the search query contains a diacritic, the match becomes diacritic sensitive
    public var match: String?

    /// An optional but recommended string you can provide to populate into Alfred's search field
    /// if the user auto-complete's the selected result (⇥ by default).
    ///
    /// If the item is set to "valid": false, the auto-complete text is populated into Alfred's search field when the user actions the result
    public var autocomplete: String?

    /// By specifying "type": "file", Alfred treats your result as a file on your system.
    /// This allows the user to perform actions on the file like they can with Alfred's standard file filters
    public var type: ItemType?

    /// The mod element gives you control over how the modifier keys react. It can alter the looks of a result 
    public var mods = [Modifier: ModifierAction]()

    /// This element defines the Universal Action items used when actioning the result, and overrides the arg being used for actioning.
    public var action: UniversalAction?

    /// Defines the text the user will get when copying the selected result row with ⌘C or displaying large type with ⌘L.
    ///
    /// default: `arg`
    public var text: Text?

    /// A Quick Look URL which will be visible if the user uses the Quick Look feature within Alfred (tapping shift, or ⌘Y).
    /// quicklookurl will also accept a file path, both absolute and relative to home using ~/.
    ///
    /// default: `arg`
    public var quicklookurl: String?

    /// Variables within a variables object will be passed out of the script filter and remain accessible throughout the current session as environment variables.
    /// In addition, they are passed back in when the script reruns within the same session.
    /// This can be used for managing state between runs as the user types input or when the script is set to re-run after an interval.
    public var variables = [String: String]()

    public init(
        uid: String? = nil,
        title: String,
        subtitle: String,
        arg: Argument? = nil,
        icon: Icon? = nil,
        valid: Bool = true,
        match: String? = nil,
        autocomplete: String? = nil,
        type: ItemType? = nil,
        mods: [Modifier: ModifierAction] = [:],
        action: UniversalAction? = nil,
        text: Text? = nil,
        quicklookurl: String? = nil,
        variables: [String: String] = [:]
    ) {
        self.uid = uid
        self.title = title
        self.subtitle = subtitle
        self.arg = arg
        self.icon = icon
        self.valid = valid
        self.match = match
        self.autocomplete = autocomplete
        self.type = type
        self.mods = mods
        self.action = action
        self.text = text
        self.quicklookurl = quicklookurl
        self.variables = variables
    }
}

// MARK: - Convenient methods
extension Item {
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

    public func set(_ action: ModifierAction, for mod: Modifier) -> Item {
        var item = self
        item.mods[mod] = action
        return item
    }

    public func setVariable(_ value: String, for key: String) -> Item {
        var item = self
        item.variables[key] = value
        return item
    }
}

// MARK: - ItemRepresentable
extension Item : ItemRepresentable {
    public var item: Item { self }
}

// MARK: - Encodable
extension Item: Encodable {
    private enum CodingKeys: String, CodingKey {
        case uid, title, subtitle, arg, icon,
             valid, match, autocomplete, type, mods,
             action, text, quicklookurl, variables
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfNotEmpty(uid, forKey: .uid)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encodeIfNotNil(arg, forKey: .arg)
        try container.encodeIfNotNil(icon, forKey: .icon)
        try container.encodeIfNotEmpty(match, forKey: .match)
        try container.encodeIfNotEmpty(autocomplete, forKey: .autocomplete)
        try container.encodeIfNotNil(type, forKey: .type)
        try container.encodeIfNotNil(action, forKey: .action)
        try container.encodeIfNotNil(text, forKey: .text)
        try container.encodeIfNotEmpty(quicklookurl, forKey: .quicklookurl)
        try container.encodeIfNotEmpty(variables, forKey: .variables)

        if !valid {
            try container.encode(valid, forKey: .valid)
        }

        let dict = mods.reduce(into: [String: ModifierAction]()) { result, item in
            result[item.key.description] = item.value
        }
        try container.encodeIfNotEmpty(dict, forKey: .mods)

    }
}
