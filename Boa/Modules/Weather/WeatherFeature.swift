import UIKit


final class WeatherFeature {
    
    fileprivate let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol WeatherFeatureType: class {
    func showInWindow(_ window: UIWindow)
}

// MARK: - WeatherFeatureType
extension WeatherFeature: WeatherFeatureType {

    func showInWindow(_ window: UIWindow) {
        let controller = storyboard.instantiateViewController(withIdentifier: "Weather") as! WeatherViewController
        window.rootViewController = UINavigationController(rootViewController: controller)
        window.makeKeyAndVisible()
    }
}
