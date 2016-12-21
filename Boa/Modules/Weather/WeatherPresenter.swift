import Foundation


final class WeatherPresenter {
    
    var router: WeatherRouterType!
    var interactor: WeatherInteractorType!
    weak var view: WeatherViewType?
    
    init(view: WeatherViewType) {
        self.view = view
    }
}

protocol WeatherPresenterViewType: class {
    func requestWeatherReports()
    func requestDetailsForWeatherReports(weatherReports: [WeatherReportEntity], atIndex index: Int)
    func requestAddCity()
}

// MARK: - WeatherPresenterViewType
extension WeatherPresenter: WeatherPresenterViewType {
    
    func requestWeatherReports() {
        interactor.fetchWeatherReports()
    }
    
    func requestDetailsForWeatherReports(weatherReports: [WeatherReportEntity], atIndex index: Int) {
        router.showDetailsForWeatherReport(weatherReports: weatherReports, atIndex: index)
    }
    
    func requestAddCity() {
        router.showAddCity()
    }
}

protocol WeatherPresenterInteractorType: class {
    func successfullyFetchedWeatherReports(weatherReports: [WeatherReportEntity])
    func failedToFetchWeatherReports(error: Error)
}

// MARK: - WeatherPresenterInteractorType
extension WeatherPresenter: WeatherPresenterInteractorType {

    func successfullyFetchedWeatherReports(weatherReports: [WeatherReportEntity]) {
        asyncMain {
            self.view?.displayWeatherReports(weatherReports: weatherReports)
        }
    }
    
    func failedToFetchWeatherReports(error: Error) {
        asyncMain {
            self.view?.displayError(error: error)
        }
    }
}
