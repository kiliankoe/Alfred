public struct ComplexArgument: Encodable, Equatable {
    var argument: String?
    var variables: [String: String] = [:]

    public init(argument: String? = nil, variables: [String: String]? = nil) {
        self.argument = argument
        if let variables = variables {
            self.variables = variables
        }
    }
}

public enum Argument: Encodable, Equatable {
    case simple(String)
    case complex(ComplexArgument)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .simple(let string):
            try container.encode(string)
        case .complex(let complex):
            struct Wrapper: Encodable {
                let alfredworkflow: ComplexArgument
            }
            let wrapper = Wrapper(alfredworkflow: complex)
            try container.encode(wrapper)
        }
    }
}
