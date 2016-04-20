import UIKit
import Cobra


final class WeatherDetailRouter {
    
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol WeatherDetailRouterType: class {

}

// MARK: - WeatherDetailRouterType
extension WeatherDetailRouter: WeatherDetailRouterType {
   
}
