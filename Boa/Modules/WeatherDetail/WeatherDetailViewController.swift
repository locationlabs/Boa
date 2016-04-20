import UIKit


final class WeatherDetailViewController: UIViewController {
    
    var presenter: WeatherDetailPresenterViewType!
    var styler: WeatherDetailStyleType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
    }
}

protocol WeatherDetailViewType: class {
    
}

// MARK: - WeatherDetailViewType
extension WeatherDetailViewController: WeatherDetailViewType {
   
}

// MARK: - Private
private extension WeatherDetailViewController {
   func applyStyles() {
        
    }
}

