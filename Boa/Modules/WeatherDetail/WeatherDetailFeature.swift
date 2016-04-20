import UIKit


final class WeatherDetailFeature {
    
    private let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol WeatherDetailFeatureType: class {
    func showFromViewController(fromViewController: UIViewController, weatherReport: WeatherReportEntity)
}

// MARK: - WeatherDetailFeatureType
extension WeatherDetailFeature: WeatherDetailFeatureType {
   
    func showFromViewController(fromViewController: UIViewController, weatherReport: WeatherReportEntity) {
        let controller = storyboard.instantiateViewControllerWithIdentifier("WeatherDetail") as! WeatherDetailViewController
        fromViewController.showViewController(controller, sender: nil)
    }
}
