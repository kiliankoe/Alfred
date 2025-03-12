import Foundation

/// Scripts which take a while to return can cache results so users see data sooner on subsequent runs
public struct Cache: Encodable {
    /// Time to live for cached data is defined as a number of seconds between 5 and 86400 (i.e. 24 hours).
    var seconds: Int

    /// The optional loosereload key asks the Script Filter to try to show any cached data first.
    /// If it's determined to be stale, the script runs in the background and replaces results with the new data when it becomes available
    var loosereload: Bool

    public init(seconds: Int, loosereload: Bool) {
        self.seconds = seconds
        self.loosereload = loosereload
    }
}
