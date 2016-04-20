import UIKit


final class WeatherViewController: UIViewController {
    
    var presenter: WeatherPresenterViewType!
    var styler: WeatherStyleType!
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var weatherReports = [WeatherReportEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorStyle = .None
        
        presenter.requestGreeting()
        presenter.requestWeatherReports()
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
    func displayGreeting(date: NSDate, message: String)
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
        cell.temperatureLabel.text = "\(weatherReport.temparture)"
        
        // apply styles to cell
        styler.styleGradientLayer(cell.gradientLayer, forTemparture: weatherReport.temparture)
        styler.styleCityNameLabel(cell.nameLabel, forTemparture: weatherReport.temparture)
        styler.styleTemparatureLabel(cell.temperatureLabel, forTemparture: weatherReport.temparture)
        
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
        presenter.requestDetailsForWeatherReport(weatherReport)
    }
}

// MARK: - Private
private extension WeatherViewController {
   func applyStyles() {
        styler.styleNavigationBar(navigationController!.navigationBar)
        styler.styleAddBarButtonItem(addBarButtonItem)
    }
}

