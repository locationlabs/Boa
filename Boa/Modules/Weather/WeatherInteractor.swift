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
    
    func fetchGreeting()
    func fetchWeatherReports()
}

// MARK: - WeatherInteractorType
extension WeatherInteractor: WeatherInteractorType {

    func fetchGreeting() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let hour = calendar.component(.Hour, fromDate: date)

        switch hour {
        case 0..<12:
            presenter?.successfullyFetchedGreeting(date, message: "Good Monring")
        case 12..<18:
            presenter?.successfullyFetchedGreeting(date, message: "Good Afternoon")
        default:
            presenter?.successfullyFetchedGreeting(date, message: "Good Evening")
        }
        
    }
    
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
