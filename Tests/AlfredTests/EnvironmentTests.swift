import XCTest
import Alfred

final class EnvironmentTests: XCTestCase {
    func testPreferences() {
        setenv("alfred_preferences", "test_prefs", 0)
        XCTAssertEqual(Environment.preferences, "test_prefs")

        setenv("alfred_preferences_localhash", "deadbeef", 0)
        XCTAssertEqual(Environment.localPreferences, "test_prefs/preferences/local/deadbeef")
    }

    func testTheme() {
        setenv("alfred_theme", "alfred.theme.yosemite", 0)
        XCTAssertEqual(Environment.theme, "alfred.theme.yosemite")

        setenv("alfred_theme_background", "rgba(255,255,255,1.0)", 0)
        XCTAssertEqual(Environment.themeBackground, "rgba(255,255,255,1.0)")

        setenv("alfred_theme_selection_background", "rgba(255,255,255,1.0)", 0)
        XCTAssertEqual(Environment.themeSelectionBackground, "rgba(255,255,255,1.0)")

        setenv("alfred_theme_subtext", "1", 0)
        XCTAssertEqual(Environment.themeSubtext?.rawValue, 1)
    }

    func testAlfredVersion() {
        setenv("alfred_version", "2.4", 0)
        XCTAssertEqual(Environment.alfredVersion, "2.4")

        setenv("alfred_version_build", "277", 0)
        XCTAssertEqual(Environment.alfredVersionBuild, 277)
    }

    func testWorkflowMetadata() {
        setenv("alfred_workflow_bundleid", "com.alfredapp.david.googlesuggest", 0)
        XCTAssertEqual(Environment.workflowBundleID, "com.alfredapp.david.googlesuggest")

        setenv("alfred_workflow_cache", "/Users/Crayons/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.alfredapp.david.googlesuggest", 0)
        XCTAssertEqual(Environment.workflowCacheDir, "/Users/Crayons/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.alfredapp.david.googlesuggest")

        setenv("alfred_workflow_data", "/Users/Crayons/Library/Application Support/Alfred 2/Workflow Data/com.alfredapp.david.googlesuggest", 0)
        XCTAssertEqual(Environment.workflowDataDir, "/Users/Crayons/Library/Application Support/Alfred 2/Workflow Data/com.alfredapp.david.googlesuggest")

        setenv("alfred_workflow_name", "Google Suggest", 0)
        XCTAssertEqual(Environment.workflowName, "Google Suggest")

        setenv("alfred_workflow_uid", "user.workflow.B0AC54EC-601C-479A-9428-01F9FD732959", 0)
        XCTAssertEqual(Environment.workflowUID, "user.workflow.B0AC54EC-601C-479A-9428-01F9FD732959")

        setenv("alfred_workflow_version", "1.0", 0)
        XCTAssertEqual(Environment.workflowVersion, "1.0")
    }

    func testIsDebug() {
        setenv("alfred_debug", "1", 0)
        XCTAssertTrue(Environment.isDebug)
    }
}

