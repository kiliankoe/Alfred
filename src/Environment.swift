import Foundation
import class AppKit.NSColor

/// Access workflow environment variables
///
/// See the [Alfred Workflow Documentation](https://www.alfredapp.com/help/workflows/script-environment-variables/) for more info.
public enum Env {
    /// Location of the Alfred.alfredpreferences.
    ///
    /// Example output: "/Users/Crayons/Dropbox/Alfred/Alfred.alfredpreferences"
    public static var preferences: String? {
        return envvar("alfred_preferences")
    }

    /// Location of local (Mac-specific) preferences.
    ///
    /// Example output: "adbd4f66bc3ae8493832af61a41ee609b20d8705"
    public static var localPreferences: String? {
        guard
            let preferences = Env.preferences,
            let localHash = envvar("alfred_preferences_localhash")
        else {
            return nil
        }

        return "\(preferences)/preferences/local/\(localHash)"
    }

    /// Current Alfred theme.
    ///
    /// Example output: "alfred.theme.yosemite"
    public static var theme: String? {
        return envvar("alfred_theme")
    }

    /// Theme background color.
    ///
    /// Example output: "rgba(255,255,255,0.98)"
    public static var themeBackground: String? {
        return envvar("alfred_theme_background")
    }

    /// Theme background color
    public static var themeBackgroundColor: NSColor? {
        guard
            let themeBg = Env.themeBackground,
            let color = NSColor(withRGBA: themeBg)
        else {
            return nil
        }

        return color
    }

    /// Theme's selected item background color.
    ///
    /// Example output: "rgba(255,255,255,0.98)"
    public static var themeSelectionBackground: String? {
        return envvar("alfred_theme_selection_background")
    }

    /// Theme's selected item background color.
    public static var themeSelectionBackgroundColor: NSColor? {
        guard
            let themeSelBg = Env.themeSelectionBackground,
            let color = NSColor(withRGBA: themeSelBg)
        else {
            return nil
        }

        return color
    }

    /// Subtext mode the user selected in the Appearance settings.
    public static var themeSubtext: Subtext? {
        guard
            let subtextStr = envvar("alfred_theme_subtext"),
            let subtext = Int(subtextStr),
            let mode = Subtext(rawValue: subtext)
        else {
            return nil
        }

        return mode
    }

    /// Subtext mode in Alfred's Appearance settings.
    public enum Subtext: Int {
        /// Always show subtext
        case always
        /// Only show subtext for alternative actions
        case alternativeActions
        /// Only show subtext for the selected result
        case selectedResult
        /// Never show subtext
        case never
    }

    /// Currently running Alfred's version.
    ///
    /// Example output: "2.4"
    public static var alfredVersion: String? {
        return envvar("alfred_version")
    }

    /// Currently running Alfred's build number.
    ///
    /// Example output: 277
    public static var alfredVersionBuild: Int? {
        guard
            let buildStr = envvar("alfred_version_build"),
            let build = Int(buildStr)
        else {
            return nil
        }

        return build
    }

    /// This workflow's bundle identifier.
    ///
    /// Example output: "com.alfredapp.david.googlesuggest"
    public static var workflowBundleID: String? {
        return envvar("alfred_workflow_bundleid")
    }

    /// Recommended location for storing this workflow's volatile data.
    ///
    /// - Note: Will only be populated if the workflow has a bundleID.
    ///
    /// Example output: "/Users/Crayons/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.alfredapp.david.googlesuggest"
    public static var workflowCacheDir: String? {
        return envvar("alfred_workflow_cache")
    }

    /// Recommended location for storing this workflow's non-volatile data.
    ///
    /// - Note: Will only be populated if the workflow has a bundleID.
    ///
    /// Example output: "/Users/Crayons/Library/Application Support/Alfred 2/Workflow Data/com.alfredapp.david.googlesuggest"
    public static var workflowDataDir: String? {
        return envvar("alfred_workflow_data")
    }

    /// This workflow's name.
    ///
    /// Example output: "Google Suggest"
    public static var workflowName: String? {
        return envvar("alfred_workflow_name")
    }

    /// This workflow's unique identifier.
    ///
    /// Example output: "user.workflow.B0AC54EC-601C-479A-9428-01F9FD732959"
    public static var workflowUID: String? {
        return envvar("alfred_workflow_uid")
    }

    /// This workflow's version string.
    public static var workflowVersion: String? {
        return envvar("alfred_workflow_version")
    }

    /// Does the user currently have the debug panel open for this workflow?
    public static var isDebug: Bool {
        guard let debug = envvar("alfred_debug") else { return false }
        return debug == "1"
    }

    private static func envvar(_ key: String) -> String? {
        return ProcessInfo.processInfo.environment[key]
    }
}

private extension NSColor {
    convenience init?(withRGBA rgba: String) {
        let numberRegex = try! NSRegularExpression(pattern: "(\\d+\\.?\\d+)")
        let nsrgba = rgba as NSString
        let matches = numberRegex.matches(in: rgba, range: NSRange(location: 0, length: nsrgba.length))
        let results = matches
            .map { nsrgba.substring(with: $0.range) }
            .flatMap { Double($0) }
            .map { CGFloat($0) }
        guard results.count == 4 else { return nil }
        self.init(red: results[0], green: results[1], blue: results[2], alpha: results[3])
    }
}
