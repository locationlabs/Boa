import UIKit
import Cobra
import Gorgon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        logDebug(message: "Application starting...")
        
        //
        // STEP 1
        // Enabling debug logging for frameworks. You shouldn't enable logging in production
        //
        Gorgon.Log.enableDebugging = true
        Cobra.Log.enableDebugging = true
        
        //
        // STEP 2
        // Create a Cobra configuration for assembling the components and properties for the application
        //
        let config = Config(components: [
            Component<DaemonAssembly>(),
            Component<ServiceAssembly>()
        ], properties: [
            JsonProperty(name: "properties")
        ])
        
        //
        // STEP 3
        // Provide the configuration to the Cobra application
        //
        try! App.sharedInstance.config(config)

        //
        // STEP 4
        // Register Feature to Module proxies for the Cobra application routes
        //
        App.sharedInstance.registerProxies([
            Proxy<AddCityFeatureType>(modules: Module<AddCityAssembly>()),
            Proxy<WeatherFeatureType>(modules: Module<WeatherAssembly>()),
            Proxy<WeatherDetailFeatureType>(modules: Module<WeatherDetailAssembly>())
        ])
        
        //
        // STEP 5
        // Route to our first feature in our application window
        //
        try! App.sharedInstance.feature(WeatherFeatureType.self).showInWindow(window!)
        return true
    }
}

/**
 Simple logging function to load to NSLoad with a prefix
 
 - parameter message: the message to load
 */
func logDebug( message: @autoclosure () -> String) {
    NSLog("[Boa] \(message())")
}
