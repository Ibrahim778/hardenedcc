import SwiftUI
import Comet
import HardenedCCPrefsC

class RootListController: CMViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup(content: RootView())
        self.title = "HardenedCC"
    }
}
