import XCTest
import Alfred

final class IconTests: XCTestCase {
    func testEncode() throws {
        let icon = Icon(path: "path", type: .fileicon)
        let json = try encodeToString(icon)
        XCTAssertEqual(json, """
        {
          "path" : "path",
          "type" : "fileicon"
        }
        """)
    }
}
