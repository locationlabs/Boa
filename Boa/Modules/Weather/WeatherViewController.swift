import UIKit



final class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenterViewType!
    var styler: WeatherStyleType!
    var isCelcius: Bool = false
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var weatherReports = [WeatherReportEntity]()
    fileprivate var selectedIndexPath: IndexPath?

    @IBOutlet weak var footerView: WeatherTableFooterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
        
        navigationController?.isNavigationBarHidden = true
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        
        presenter.requestWeatherReports()
        
        tableView.tableFooterView = footerView
        footerView.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func doAdd(_ sender: AnyObject) {
        presenter.requestAddCity()
    }
}

protocol WeatherViewType: class {
    func displayWeatherReports(_ weatherReports: [WeatherReportEntity])
    func displayError(_ error: Error)
}

// MARK: - WeatherViewType
extension WeatherViewController: WeatherViewType {
    
    func displayWeatherReports(_ weatherReports: [WeatherReportEntity]) {
        self.weatherReports = weatherReports
        tableView.reloadData()
    }
    
    func displayError(_ error: Error) {
        logDebug(message: "TODO")
    }
    
    func displayGreeting(_ date: Date, message: String) {
        title = message
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherReport = weatherReports[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! WeatherTableViewCell
        
        // set content on cell
        cell.nameLabel.text = weatherReport.city.name
        if isCelcius {
            cell.temperatureLabel.text = String(format: "%.fº", weatherReport.temperature.degreesInCelsius)
        } else {
            cell.temperatureLabel.text = String(format: "%.fº", weatherReport.temperature.degreesInFahrenheit)
        }
        
        // apply styles to cell
        styler.styleGradientLayer(cell.gradientLayer, forTemparture: weatherReport.temperature)
        styler.styleCityNameLabel(cell.nameLabel, forTemparture: weatherReport.temperature)
        styler.styleTemparatureLabel(cell.temperatureLabel, forTemparture: weatherReport.temperature)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath

        presenter.requestDetailsForWeatherReports(weatherReports, atIndex: indexPath.row)
    }
}

// MARK: - Footer Delegate
extension WeatherViewController: FooterViewDelegate {
    func didPressAdd() {
        presenter.requestAddCity()
    }
    
    func didPressWeatherFormatButton() {

        if isCelcius {
            isCelcius = false
        } else {
            isCelcius = true
        }
        
        styler.styleFooterView(footerView, isCelcius: isCelcius)
        tableView.reloadData()
    }
}


// MARK: - Cell Animtions
extension WeatherViewController : ExpandingTransitionPresentingViewController {
    func expandingTransitionTargetViewForTransition(transition: ExpandingCellTransition) -> UIView! {
        if let indexPath = selectedIndexPath {
            return tableView.cellForRow(at: indexPath)
        }
        else {
            return nil
        }
    }
}

// MARK: - Private
private extension WeatherViewController {
    func applyStyles() {
        styler.styleFooterView(footerView, isCelcius: isCelcius)
    }
}

