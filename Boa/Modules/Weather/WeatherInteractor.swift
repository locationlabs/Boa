import Foundation
import PromiseKit


final class WeatherInteractor {
    
    weak var presenter: WeatherPresenterInteractorType?
    let dataManager: WeatherDataManagerType
    
    init(presenter: WeatherPresenterInteractorType, dataManager: WeatherDataManagerType) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

protocol WeatherInteractorType: class {
    
    func fetchWeatherReports()
}

// MARK: - WeatherInteractorType
extension WeatherInteractor: WeatherInteractorType {

    func fetchWeatherReports() {
        dataManager.fetchCities().then(on: .global()) { cities in
            return when(fulfilled: cities.map { self.dataManager.fetchWeatherReportForCity($0) })
        }.then (on: .global()) {  weatherReports in
            self.presenter?.successfullyFetchedWeatherReports(weatherReports)
        }.catch { error in
            self.presenter?.failedToFetchWeatherReports(error)
        }
    }
}
