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
    func requestDetailsForWeatherReports(_ weatherReports: [WeatherReportEntity], atIndex index: Int)
    func requestAddCity()
}

// MARK: - WeatherPresenterViewType
extension WeatherPresenter: WeatherPresenterViewType {
    
    func requestWeatherReports() {
        interactor.fetchWeatherReports()
    }
    
    func requestDetailsForWeatherReports(_ weatherReports: [WeatherReportEntity], atIndex index: Int) {
        router.showDetailsForWeatherReport(weatherReports, atIndex: index)
    }
    
    func requestAddCity() {
        router.showAddCity()
    }
}

protocol WeatherPresenterInteractorType: class {
    func successfullyFetchedWeatherReports(_ weatherReports: [WeatherReportEntity])
    func failedToFetchWeatherReports(_ error: Error)
}

// MARK: - WeatherPresenterInteractorType
extension WeatherPresenter: WeatherPresenterInteractorType {

    func successfullyFetchedWeatherReports(_ weatherReports: [WeatherReportEntity]) {
        asyncMain {
            self.view?.displayWeatherReports(weatherReports)
        }
    }
    
    func failedToFetchWeatherReports(_ error: Error) {
        asyncMain {
            self.view?.displayError(error)
        }
    }
}
