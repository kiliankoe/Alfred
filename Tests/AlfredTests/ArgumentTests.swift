import XCTest
import Alfred

final class ArgumentTests: XCTestCase {
    func testEncodeSimpleArgument() throws {
        let arg = Argument.single("arg")
        let json = try encodeToString(arg)
        XCTAssertEqual(json, #""arg""#)
    }

    func testEncodeComplexArgument() throws {
        let arg = Argument.array(["var", "val"])
        let json = try encodeToString(arg)
        XCTAssertEqual(json,
        """
        [
          "var",
          "val"
        ]
        """)
    }
}
