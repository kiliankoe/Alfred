import Foundation

struct ResponseModel {

    /// Each item describes a result row displayed in Alfred
    var items: [Item]

    /// Variables within a `variables` object will be passed out of the script filter and remain accessible throughout the current session as environment variables
    var variables: [String: String]

    /// `skipknowledge == true` preserves the given item order while allowing Alfred to retain knowledge of your items,
    /// like your current selection during a re-run.
    var skipknowledge: Bool = false

    /// Scripts can be set to re-run automatically after an interval using the `rerun` key with a value from 0.1 to 5.0 seconds
    var rerun: Int = 0

    /// Scripts which take a while to return can cache results so users see data sooner on subsequent runs
    var cache: Cache?
}

// MARK: - Encodable
extension ResponseModel : Encodable {
    private enum CodingKeys: String, CodingKey {
        case items, variables, cache, rerun, skipknowledge
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfNotEmpty(items, forKey: .items)
        try container.encodeIfNotEmpty(variables, forKey: .variables)
        try container.encodeIfNotNil(cache, forKey: .cache)

        if skipknowledge {
            try container.encode(skipknowledge, forKey: .skipknowledge)
        }

        if rerun > 0 {
            try container.encode(rerun, forKey: .rerun)
        }
    }
}
