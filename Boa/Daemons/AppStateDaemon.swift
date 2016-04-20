import UIKit
import Medusa


/**
The AppStateDaemon will do something when the app goes to the background
*/
final class AppStateDaemon {
    
}

// MARK: - ApplicationDidFinishLaunchingDaemonType
extension AppStateDaemon: ApplicationDaemonType {
    
    func applicationDidEnterBackground(application: UIApplication) {
        logDebug("AppStateDaemon did enter background")
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        logDebug("AppStateDaemon did become active")
    }
}
