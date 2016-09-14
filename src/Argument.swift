public struct ComplexArgument {
  var argument: String?
  var variables = [String: CustomStringConvertible]()

  init(argument: String? = nil, variables: [String: CustomStringConvertible]? = nil) {
    self.argument = argument
    if let vars = variables {
      self.variables = vars
    }
  }

  var json: [String: Any] {
    var j = [String: Any]()
    j["arg"] = argument
    j["variables"] = self.variables
    return ["alfredworkflow": j]
  }
}

public enum Argument {
  case simple(String)
  case complex(ComplexArgument)

  var json: Any {
    switch self {
      case .simple(let argument):
        return argument
      case .complex(let argument):
        return jsonString(object: argument.json)
    }
  }
}
