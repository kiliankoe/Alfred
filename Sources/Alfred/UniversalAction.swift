import Foundation

public enum UniversalAction {
    case single(String)
    case array([String])
    case object(Action)

    public struct Action: Encodable {
        var text: [String] = []
        var url: String?
        var file: String?
        var auto: String

        public init(
            text: [String] = [],
            url: String? = nil,
            file: String? = nil,
            auto: String
        ) {
            self.text = text
            self.url = url
            self.file = file
            self.auto = auto
        }
    }
}

// MARK: - Encodable
extension UniversalAction: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .single(let strn): try container.encode(strn)
        case .array(let nest): try container.encode(nest)
        case .object(let obj): try container.encode(obj)
        }
    }
}

// MARK: - ExpressibleByArrayLiteral
extension UniversalAction: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = String

    public init(arrayLiteral elements: Self.ArrayLiteralElement...) {
        self = .array(elements)
    }
}

// MARK: - ExpressibleByStringLiteral
extension UniversalAction: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .single(value)
    }
}
