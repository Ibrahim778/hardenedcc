import SwiftUI

struct RootView: View {
    @StateObject private var preferenceStorage = PreferenceStorage()
    
    var body: some View {
        Form {
            Section {
                Toggle("Enabled", isOn: $preferenceStorage.enabled)
            } header: {
                Text("Enable / Disable tweak")
            }
            
            Section {
                Toggle("Airplane Mode", isOn: $preferenceStorage.airplane)
                Toggle("Cellular Data", isOn: $preferenceStorage.cell)
                Toggle("Personal Hotspot", isOn: $preferenceStorage.hotspot)
                Toggle("Bluetooth", isOn: $preferenceStorage.bluetooth)
                Toggle("WiFi", isOn: $preferenceStorage.wifi)
                Toggle("Airdrop", isOn: $preferenceStorage.airdrop)
            } footer: {
                Text("Toggle individual elements while locked")
            }
        }
    }
}
