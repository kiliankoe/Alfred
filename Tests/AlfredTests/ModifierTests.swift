import XCTest
import Alfred

final class ModifierTests: XCTestCase {
    func testEncodeValidModifier() throws {
        let modifier = Modifier(
            arg: .simple("arg"),
            subtitle: "subtitle")
        let json = try encodeToString(modifier)
        XCTAssertEqual(json, """
        {
          "arg" : "arg",
          "subtitle" : "subtitle"
        }
        """)
    }

    func testEncodeInvalidModifier() throws {
        var modifier = Modifier(
            arg: .simple("arg"),
            subtitle: "subtitle")
        modifier.valid = false
        let json = try encodeToString(modifier)
        XCTAssertEqual(json, """
        {
          "arg" : "arg",
          "subtitle" : "subtitle",
          "valid" : false
        }
        """)
    }
}
