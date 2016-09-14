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
        dataManager.fetchCities().thenInBackground { cities in
            return when(cities.map { self.dataManager.fetchWeatherReportForCity($0) })
        }.thenInBackground { weatherReports in
            self.presenter?.successfullyFetchedWeatherReports(weatherReports)
        }.error { error in
            self.presenter?.failedToFetchWeatherReports(error)
        }
    }
}
