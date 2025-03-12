import Foundation

extension KeyedEncodingContainer {
    mutating func encodeIfNotNil<T: Encodable>(_ value: T?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let value = value else { return }
        try encode(value, forKey: key)
    }

    mutating func encodeIfNotEmpty<T: Encodable & Collection>(_ value: T?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let value = value, !value.isEmpty else { return }
        try encode(value, forKey: key)
    }
}
