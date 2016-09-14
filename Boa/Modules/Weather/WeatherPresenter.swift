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
        router.showDetailsForWeatherReport(weatherReports, atIndex: index)
    }
    
    func requestAddCity() {
        router.showAddCity()
    }
}

protocol WeatherPresenterInteractorType: class {
    func successfullyFetchedWeatherReports(weatherReports: [WeatherReportEntity])
    func failedToFetchWeatherReports(error: ErrorType)
}

// MARK: - WeatherPresenterInteractorType
extension WeatherPresenter: WeatherPresenterInteractorType {

    func successfullyFetchedWeatherReports(weatherReports: [WeatherReportEntity]) {
        asyncMain {
            self.view?.displayWeatherReports(weatherReports)
        }
    }
    
    func failedToFetchWeatherReports(error: ErrorType) {
        asyncMain {
            self.view?.displayError(error)
        }
    }
}
