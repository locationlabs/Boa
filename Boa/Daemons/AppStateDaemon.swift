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
        logDebug(message: "AppStateDaemon did enter background")
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        logDebug(message: "AppStateDaemon did become active")
    }
}
