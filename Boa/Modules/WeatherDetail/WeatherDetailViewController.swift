import UIKit


final class WeatherDetailViewController: UIViewController {
    
    var styler: WeatherDetailStyleType!
    var weatherReport: WeatherReportEntity!
    
    @IBOutlet weak var weatherTitleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTitleLabel.text = weatherReport.city.name
        temperatureLabel.text = String(weatherReport.temperature.degreesInFahrenheit)
        applyStyles()
    }
}

// MARK: - Private
private extension WeatherDetailViewController {
    func applyStyles() {
        styler.styleGradientView(view: view, withTemperature: weatherReport.temperature)
    }
}
