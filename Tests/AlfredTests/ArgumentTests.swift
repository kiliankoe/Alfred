import XCTest
import Alfred

final class ArgumentTests: XCTestCase {
    func testEncodeSimpleArgument() throws {
        let arg = Argument.simple("arg")
        let json = try encodeToString(arg)
        XCTAssertEqual(json, #""arg""#)
    }

    func testEncodeComplexArgument() throws {
        let arg = Argument.complex(.init(
            argument: "arg",
            variables: ["var": "val"]))
        let json = try encodeToString(arg)
        XCTAssertEqual(json, """
        {
          "alfredworkflow" : {
            "argument" : "arg",
            "variables" : {
              "var" : "val"
            }
          }
        }
        """)
    }

    func testEncodeComplexArgumentWithoutVariables() throws {
        let arg = Argument.complex(.init(
            argument: "arg"))
        let json = try encodeToString(arg)
        XCTAssertEqual(json, """
        {
          "alfredworkflow" : {
            "argument" : "arg",
            "variables" : {

            }
          }
        }
        """)
    }
}
