#if !canImport(ObjectiveC)
import XCTest

extension ArgumentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ArgumentTests = [
        ("testEncodeComplexArgument", testEncodeComplexArgument),
        ("testEncodeComplexArgumentWithoutVariables", testEncodeComplexArgumentWithoutVariables),
        ("testEncodeSimpleArgument", testEncodeSimpleArgument),
    ]
}

extension EnvironmentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EnvironmentTests = [
        ("testAlfredVersion", testAlfredVersion),
        ("testIsDebug", testIsDebug),
        ("testPreferences", testPreferences),
        ("testTheme", testTheme),
        ("testWorkflowMetadata", testWorkflowMetadata),
    ]
}

extension IconTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__IconTests = [
        ("testEncode", testEncode),
    ]
}

extension ItemTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ItemTests = [
        ("testBuilderAPI", testBuilderAPI),
        ("testSimpleEncode", testSimpleEncode),
    ]
}

extension ModifierActionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ModifierActionTests = [
        ("testEncodeInvalidModifier", testEncodeInvalidModifier),
        ("testEncodeValidModifier", testEncodeValidModifier),
    ]
}

extension ResponseTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ResponseTests = [
        ("testEncode", testEncode),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ArgumentTests.__allTests__ArgumentTests),
        testCase(EnvironmentTests.__allTests__EnvironmentTests),
        testCase(IconTests.__allTests__IconTests),
        testCase(ItemTests.__allTests__ItemTests),
        testCase(ModifierActionTests.__allTests__ModifierActionTests),
        testCase(ResponseTests.__allTests__ResponseTests),
    ]
}
#endif
