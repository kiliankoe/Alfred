import Foundation

public enum Modifier: Hashable, Sendable {
    public enum Key: String, Encodable, Hashable, Sendable {
        case cmd, alt, ctrl, shift, fn
    }

    case single(Key)
    case composite([Key])
}

// MARK: - Convenient
public extension Modifier {
    static let cmd = Modifier.single(.cmd)
    static let alt = Modifier.single(.alt)
    static let ctrl = Modifier.single(.ctrl)
    static let shift = Modifier.single(.shift)
    static let fn = Modifier.single(.fn)
}

// MARK: - CustomStringConvertible
extension Modifier: CustomStringConvertible {
    public var description: String {
        switch self {
        case .single(let key):
            return key.rawValue
        case .composite(let keys):
            return keys.map { $0.rawValue }.joined(separator: "+")
        }
    }
}

// MARK: - Encodable
extension Modifier: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Modifier: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Key

    public init(arrayLiteral elements: Self.ArrayLiteralElement...) {
        self = .composite(elements)
    }
}
