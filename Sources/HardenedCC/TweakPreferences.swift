import Foundation
import libroot
import HardenedCCC

final class TweakPreferences {
    private(set) var settings: Settings!
    static let shared = TweakPreferences()

    private let preferencesFilePath = jbRootPath("/var/mobile/Library/Preferences/com.mibrahim.hardenedccprefs.plist")

    func loadSettings() {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: preferencesFilePath)), let decodedSettings = try?PropertyListDecoder().decode(Settings.self, from: data) 
        {
            self.settings = decodedSettings
        } else {
            self.settings = Settings()
        }
    }
}

struct Settings: Codable {
    var enabled = true
    var airdrop = true
    var hotspot = true
    var bluetooth = false
    var airplane = false
    var cell = false
    var wifi = false
}