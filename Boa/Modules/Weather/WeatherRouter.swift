import UIKit
import Cobra


final class WeatherRouter {
    
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol WeatherRouterType: class {
    
    func showDetailsForWeatherReport(weatherReport: WeatherReportEntity)
    func showAddCity()
}

// MARK: - WeatherRouterType
extension WeatherRouter: WeatherRouterType {
    func showDetailsForWeatherReport(weatherReport: WeatherReportEntity) {
        try! App.sharedInstance.feature(WeatherDetailFeatureType.self).showFromViewController(controller, weatherReport: weatherReport)
    }
    
    func showAddCity() {
        try! App.sharedInstance.feature(AddCityFeatureType.self).showFromViewController(controller)
    }
}
