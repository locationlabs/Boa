# Boa
Boa is a sample weather application using [Cobra][1], [Gorgon][2] and [Moccasin][3], written in Swift.

![BoaGif](/Boa.gif)

# Bootstrapping
Cobra works by bootstrapping component frameworks, property files, and application modules on application launch, like so: 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        logDebug("Application starting...")
        
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

# VIPER Modules
The Weather application code consists of three [VIPER][4]-based modules: WeatherDetail, AddCity, and Weather. These correlate to respective screens the user sees in the application (Weather being the main screen). Using [Moccasin][3], VIPER scaffolding for each of these modules were generated via Xcode templates. 

# TODO
+  Connect to web service to get real-time weather information.
+  Add persistence
+  Finish add city feature

[1]: https://github.com/locationlabs/Cobra
[2]: https://github.com/locationlabs/Gorgon
[3]: https://github.com/locationlabs/Moccasin
[4]: https://www.objc.io/issues/13-architecture/viper/
