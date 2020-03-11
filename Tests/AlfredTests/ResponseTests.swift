import XCTest
import Alfred

final class ResponseTests: XCTestCase {
    func testEncode() throws {
        var response = Response(items: [
            Item(title: "item1", subtitle: "")
        ])
        response.append(item: Item(title: "item2", subtitle: ""))

        let output = try response.output()
        XCTAssertEqual(output, """
        {
          "items" : [
            {
              "subtitle" : "",
              "title" : "item1"
            },
            {
              "subtitle" : "",
              "title" : "item2"
            }
          ]
        }
        """)
    }
}
