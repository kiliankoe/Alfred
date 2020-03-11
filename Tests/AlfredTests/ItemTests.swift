import XCTest
import Alfred

final class ItemTests: XCTestCase {
    func testBuilderAPI() {
        let item = Item(title: "title", subtitle: "subtitle")
            .uid("uid")
            .arg(.simple("arg"))
            .icon("iconpath")
            .valid(false)
            .autocomplete("autocomplete")
            .type(.file)
            .cmd(ModifierAction(arg: .simple("cmd")))
            .alt(ModifierAction(arg: .simple("alt")))

        XCTAssertEqual(item.title, "title")
        XCTAssertEqual(item.subtitle, "subtitle")
        XCTAssertEqual(item.uid, "uid")
        XCTAssertEqual(item.arg, .simple("arg"))
        XCTAssertEqual(item.icon, Icon(path: "iconpath"))
        XCTAssertEqual(item.valid, false)
        XCTAssertEqual(item.autocomplete, "autocomplete")
        XCTAssertEqual(item.type, .file)
        XCTAssertEqual(item.cmd, ModifierAction(arg: .simple("cmd")))
        XCTAssertEqual(item.alt, ModifierAction(arg: .simple("alt")))
    }

    func testSimpleEncode() throws {
        let item = Item(title: "title",
                        subtitle: "subtitle",
                        arg: .simple("arg"))
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
