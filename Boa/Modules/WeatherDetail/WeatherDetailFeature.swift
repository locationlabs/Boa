import UIKit


final class WeatherDetailFeature {
    
    fileprivate let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol WeatherDetailFeatureType: class {
    func showFromViewController(_ fromViewController: UIViewController, weatherReports: [WeatherReportEntity], atIndex index: Int)
}

// MARK: - WeatherDetailFeatureType
extension WeatherDetailFeature: WeatherDetailFeatureType {
   
    func showFromViewController(_ fromViewController: UIViewController, weatherReports: [WeatherReportEntity], atIndex index: Int) {
        let controller = storyboard.instantiateViewController(withIdentifier: "WeatherDetailPage") as! WeatherPageViewController
        controller.weatherReports = weatherReports
        controller.initialIndex = index
        fromViewController.present(controller, animated: true, completion: nil)
    }
}
