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
    func requestGreeting()
    func requestWeatherReports()
    func requestDetailsForWeatherReport(weatherReport: WeatherReportEntity)
    func requestAddCity()
}

// MARK: - WeatherPresenterViewType
extension WeatherPresenter: WeatherPresenterViewType {
    
    func requestGreeting() {
        interactor.fetchGreeting()
    }
    
    func requestWeatherReports() {
        interactor.fetchWeatherReports()
    }
    
    func requestDetailsForWeatherReport(weatherReport: WeatherReportEntity) {
        router.showDetailsForWeatherReport(weatherReport)
    }
    
    func requestAddCity() {
        router.showAddCity()
    }
}

protocol WeatherPresenterInteractorType: class {
    func successfullyFetchedWeatherReports(weatherReports: [WeatherReportEntity])
    func failedToFetchWeatherReports(error: ErrorType)
    func successfullyFetchedGreeting(date: NSDate, message: String)
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
    
    func successfullyFetchedGreeting(date: NSDate, message: String) {
        asyncMain {
            self.view?.displayGreeting(date, message: message)
        }
    }
}
