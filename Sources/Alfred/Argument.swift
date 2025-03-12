import Foundation

/// The argument which is passed through the workflow to the connected output action
public enum Argument: Equatable {
    case single(String)
    case array([String])
}

// MARK: - Codable
extension Argument : Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .single(let strn): try container.encode(strn)
        case .array(let nest): try container.encode(nest)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try? container.decode(String.self)
        let nested = try? container.decode([String].self)

        switch (string, nested) {
        case let (.some(value),_): self = .single(value)
        case let (_,.some(value)): self = .array(value)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unable to decode Argument"
                )
            )
        }
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Argument: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = String

    public init(arrayLiteral elements: Self.ArrayLiteralElement...) {
        self = .array(elements)
    }
}

// MARK: - ExpressibleByStringLiteral
extension Argument: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .single(value)
    }
}
