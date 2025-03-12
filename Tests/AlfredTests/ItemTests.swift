import XCTest
import Alfred

final class ItemTests: XCTestCase {
    func testBuilderAPI() {
        let item = Item(title: "title", subtitle: "subtitle")
            .uid("uid")
            .arg(.single("arg"))
            .icon("iconpath")
            .valid(false)
            .autocomplete("autocomplete")
            .type(.file)
            .set(ModifierAction(arg: "cmd"), for: .cmd)
            .set(ModifierAction(arg: "alt"), for: .alt)

        XCTAssertEqual(item.title, "title")
        XCTAssertEqual(item.subtitle, "subtitle")
        XCTAssertEqual(item.uid, "uid")
        XCTAssertEqual(item.arg, .single("arg"))
        XCTAssertEqual(item.icon, Icon(path: "iconpath"))
        XCTAssertEqual(item.valid, false)
        XCTAssertEqual(item.autocomplete, "autocomplete")
        XCTAssertEqual(item.type, .file)
        XCTAssertEqual(item.mods[.cmd], ModifierAction(arg: "cmd"))
        XCTAssertEqual(item.mods[.alt], ModifierAction(arg: "alt"))
    }

    func testSimpleEncode() throws {
        let item = Item(title: "title",
                        subtitle: "subtitle",
                        arg: .single("arg"))
        let json = try encodeToString(item)
        XCTAssertEqual(json, """
        {
          "arg" : "arg",
          "subtitle" : "subtitle",
          "title" : "title"
        }
        """)
    }
}
