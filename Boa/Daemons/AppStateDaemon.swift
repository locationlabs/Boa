import UIKit
import Gorgon


/**
The AppStateDaemon will do something when the app goes to the background
*/
final class AppStateDaemon {
    
}

// MARK: - ApplicationDidFinishLaunchingDaemonType
extension AppStateDaemon: ApplicationDaemonType {
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        logDebug("AppStateDaemon did enter background")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        logDebug("AppStateDaemon did become active")
    }
}
