import UIKit



final class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenterViewType!
    var styler: WeatherStyleType!
    var isCelcius: Bool = false
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var weatherReports = [WeatherReportEntity]()
    private var selectedIndexPath: NSIndexPath?

    @IBOutlet weak var footerView: WeatherTableFooterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
        
        navigationController?.navigationBarHidden = true
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorStyle = .None
        
        presenter.requestWeatherReports()
        
        tableView.tableFooterView = footerView
        footerView.delegate = self
        //(tableView.tableFooterView as! WeatherTableFooterView).delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func doAdd(sender: AnyObject) {
        presenter.requestAddCity()
    }
}

protocol WeatherViewType: class {
    func displayWeatherReports(weatherReports: [WeatherReportEntity])
    func displayError(error: ErrorType)
}

// MARK: - WeatherViewType
extension WeatherViewController: WeatherViewType {
    
    func displayWeatherReports(weatherReports: [WeatherReportEntity]) {
        self.weatherReports = weatherReports
        tableView.reloadData()
    }
    
    func displayError(error: ErrorType) {
        logDebug("TODO")
    }
    
    func displayGreeting(date: NSDate, message: String) {
        title = message
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherReports.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let weatherReport = weatherReports[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell") as! WeatherTableViewCell
        
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let weatherReport = weatherReports[indexPath.row]
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
            return tableView.cellForRowAtIndexPath(indexPath)
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

