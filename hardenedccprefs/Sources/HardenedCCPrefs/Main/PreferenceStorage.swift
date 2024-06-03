import Foundation
import Combine
import Comet
import libroot

// MARK: - Internal

final class PreferenceStorage: ObservableObject {
    private static let registry: String = jbRootPath("/var/mobile/Library/Preferences/com.mibrahim.hardenedccprefs.plist")
    /// Welcome to Comet
    /// By @ginsudev
    ///
    /// Mark your preferences with `@Published(key: "someKey", registry: PreferenceStorage.registry)`.
    /// When the value of these properties are changed, they are also saved into the preferences file on disk to persist changes.
    ///
    /// The initial value you initialise your property with is the fallback / default value that will be used if there is no present value for the
    /// given key.
    ///
    /// `@Published(key: _ registry:_)` properties can only store Foundational types that conform
    /// to `Codable` (i.e. `String, Data, Int, Bool, Double, Float`, etc).

    // Preferences
    @Published(key: "enabled", registry: registry) var enabled = false
    @Published(key: "wifi", registry: registry) var wifi = false
    @Published(key: "bluetooth", registry: registry) var bluetooth = false
    @Published(key: "cell", registry: registry) var cell = false
    @Published(key: "airplane", registry: registry) var airplane = false
    @Published(key: "hotspot", registry: registry) var hotspot = true
    @Published(key: "airdrop", registry: registry) var airdrop = true

    private var cancellables : Set<AnyCancellable> = []

    init () {
        self.objectWillChange.sink { _ in 
            let centre = CFNotificationCenterGetDarwinNotifyCenter()
            let name = "com.mibrahim.hardenedcc/Update" as CFString
            let object = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
            CFNotificationCenterPostNotification(centre, .init(name), object, nil, true)
        }.store(in: &cancellables)
    }
}
