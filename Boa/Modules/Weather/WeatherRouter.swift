import UIKit
import Cobra


final class WeatherRouter {
    
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol WeatherRouterType: class {
    
    func showDetailsForWeatherReport(weatherReports: [WeatherReportEntity], atIndex index: Int)
    func showAddCity()
}

// MARK: - WeatherRouterType
extension WeatherRouter: WeatherRouterType {
    func showDetailsForWeatherReport(weatherReports: [WeatherReportEntity], atIndex index: Int) {
        try! App.sharedInstance.feature(WeatherDetailFeatureType.self).showFromViewController(controller, weatherReports: weatherReports, atIndex: index)
    }
    
    func showAddCity() {
        try! App.sharedInstance.feature(AddCityFeatureType.self).showFromViewController(controller)
    }
}
