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
        firstly {
            dataManager.fetchCities()
        }.then { cities in
            when(fulfilled:cities.map { self.dataManager.fetchWeatherReportForCity(city: $0) })
        }.then { weatherReports in
            self.presenter?.successfullyFetchedWeatherReports(weatherReports: weatherReports)
        }.catch { error in
            self.presenter?.failedToFetchWeatherReports(error: error)
        }
    }
}
