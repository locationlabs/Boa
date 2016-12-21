import UIKit



final class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenterViewType!
    var styler: WeatherStyleType!
    var isCelcius: Bool = false
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var weatherReports = [WeatherReportEntity]()
    var selectedIndexPath: NSIndexPath?

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
        //(tableView.tableFooterView as! WeatherTableFooterView).delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func doAdd(sender: AnyObject) {
        presenter.requestAddCity()
    }
}

protocol WeatherViewType: class {
    func displayWeatherReports(weatherReports: [WeatherReportEntity])
    func displayError(error: Error)
}

// MARK: - WeatherViewType
extension WeatherViewController: WeatherViewType {
    
    func displayWeatherReports(weatherReports: [WeatherReportEntity]) {
        self.weatherReports = weatherReports
        tableView.reloadData()
    }
    
    func displayError(error: Error) {
        logDebug(message: "TODO")
    }
    
    func displayGreeting(date: NSDate, message: String) {
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
        styler.styleGradientLayer(gradientLayer: cell.gradientLayer, forTemparture: weatherReport.temperature)
        styler.styleCityNameLabel(label: cell.nameLabel, forTemparture: weatherReport.temperature)
        styler.styleTemparatureLabel(label: cell.temperatureLabel, forTemparture: weatherReport.temperature)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        selectedIndexPath = indexPath as NSIndexPath?
        
        presenter.requestDetailsForWeatherReports(weatherReports: weatherReports, atIndex: indexPath.row)
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
        
        styler.styleFooterView(view: footerView, isCelcius: isCelcius)
        

        tableView.reloadData()
    }
}


// MARK: - Cell Animtions
extension WeatherViewController : ExpandingTransitionPresentingViewController {
    func expandingTransitionTargetViewForTransition(transition: ExpandingCellTransition) -> UIView! {
        if let indexPath = selectedIndexPath {
            return tableView.cellForRow(at: indexPath as IndexPath)
        }
        else {
            return nil
        }
    }
}

// MARK: - Private
private extension WeatherViewController {
    func applyStyles() {
        
        styler.styleFooterView(view: footerView, isCelcius: isCelcius)
        

    }
}

