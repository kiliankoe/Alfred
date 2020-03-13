import Foundation
@testable import Alfred

func encodeToString<T: Encodable>(_ value: T) throws -> String {
    let json = try Response.encoder.encode(value)
    return String(data: json, encoding: .utf8)!
}
