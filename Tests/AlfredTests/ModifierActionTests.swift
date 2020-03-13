import XCTest
import Alfred

final class ModifierActionTests: XCTestCase {
    func testEncodeValidModifier() throws {
        let modifier = ModifierAction(
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
        var modifier = ModifierAction(
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
