import UIKit


final class WeatherDetailFeature {
    
    private let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol WeatherDetailFeatureType: class {
    func showFromViewController(fromViewController: UIViewController, weatherReports: [WeatherReportEntity], atIndex index: Int)
}

// MARK: - WeatherDetailFeatureType
extension WeatherDetailFeature: WeatherDetailFeatureType {
   
    func showFromViewController(fromViewController: UIViewController, weatherReports: [WeatherReportEntity], atIndex index: Int) {
        let controller = storyboard.instantiateViewControllerWithIdentifier("WeatherDetailPage") as! WeatherPageViewController
        controller.weatherReports = weatherReports
        controller.initialIndex = index
        fromViewController.presentViewController(controller, animated: true, completion: nil)
    }
}
