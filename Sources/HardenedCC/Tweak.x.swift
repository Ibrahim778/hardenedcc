import Orion
import UIKit
import HardenedCCC

var settings : Settings!

class CCRoundButtonHook : ClassHook<CCUIRoundButton> {
    // There are probably nicer ways to handle this but that's not what this tweak is for.
    func isEnabled() -> Bool {
        if(!settings.enabled) {
            return orig.isEnabled()
        }

        let aggInstance : SBLockStateAggregator = SBLockStateAggregator.sharedInstance() as! SBLockStateAggregator
        let lockState : UInt64 = aggInstance.lockState()
        
        if lockState != 0 && lockState != 1 { // locked
            guard let superView = target.superview else {
                return orig.isEnabled()
            }
    
            if let targetClass = NSClassFromString("CCUIConnectivityAirplaneViewController") {
                if(superView.viewDelegate.isKind(of: targetClass) && !settings.airplane){
                    return false
                }
            }
            if let targetClass = NSClassFromString("CCUIConnectivityCellularDataViewController") {
                if(superView.viewDelegate.isKind(of: targetClass) && !settings.cell) {
                    return false
                }
            }
            if let targetClass = NSClassFromString("CCUIConnectivityWifiViewController") {
                if(superView.viewDelegate.isKind(of: targetClass) && !settings.wifi) {
                    return false
                }
            }
            if let targetClass = NSClassFromString("CCUIConnectivityBluetoothViewController") {
                if(superView.viewDelegate.isKind(of: targetClass) && !settings.bluetooth) {
                    return false
                }
            }
            if let targetClass = NSClassFromString("CCUIConnectivityAirDropViewController") {
                if(superView.viewDelegate.isKind(of: targetClass) && !settings.airdrop) {
                    return false
                }
            }
            if let targetClass = NSClassFromString("CCUIConnectivityHotspotViewController") {
                if(superView.viewDelegate.isKind(of: targetClass) && !settings.hotspot) {
                    return false
                }
            }
        }

        return orig.isEnabled()
    }
}

class HardenedCC: Tweak {
    required init() {
        syncSettings()
    
        let center = CFNotificationCenterGetDarwinNotifyCenter()
        let name = "com.mibrahim.hardenedcc/Update" as CFString
        let observer = UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque())

        CFNotificationCenterAddObserver(center, observer, { center, observer, name, object, userInfo in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                syncSettings()
            })
        }, name, nil, .deliverImmediately)
    }

    static func handleError(_ error: OrionHookError) {
        RSLog(error.localizedDescription)
        RSLog(error.description)
        RSLog((error.errorDescription ?? "no error desc"))
        RSLog((error.failureReason ?? "no failure reason"))
        RSLog((error.helpAnchor ?? "no help"))
        RSLog((error.recoverySuggestion ?? "no recovery suggestion"))
        
        DefaultTweak.handleError(error)
    }
}

func syncSettings() {
    TweakPreferences.shared.loadSettings()
    settings = TweakPreferences.shared.settings

    RSLog("Enabled: \(settings.enabled)")
    RSLog("Airplane: \(settings.airplane)")
    RSLog("Cell: \(settings.cell)")
    RSLog("WiFi: \(settings.wifi)")
    RSLog("Bluetooth: \(settings.bluetooth)")
    RSLog("AirDrop: \(settings.airdrop)")
    RSLog("Hotspot: \(settings.hotspot)")
}