import UIKit


final class WeatherFeature {
    
    let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol WeatherFeatureType: class {
    func showInWindow(window: UIWindow)
}

// MARK: - WeatherFeatureType
extension WeatherFeature: WeatherFeatureType {

    func showInWindow(window: UIWindow) {
        let controller = storyboard.instantiateViewController(withIdentifier: "Weather") as! WeatherViewController
        window.rootViewController = UINavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
    }
}
