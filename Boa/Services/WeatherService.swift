import PromiseKit
import Darwin


final class WeatherService {
    
}

protocol WeatherServiceType: class {
    func fetchWeatherReportForCity(_ city: CityEntity) -> Promise<WeatherReportEntity>
}

// MARK: - WeatherServiceType
extension WeatherService: WeatherServiceType {

    func fetchWeatherReportForCity(_ city: CityEntity) -> Promise<WeatherReportEntity> {
        return Promise<WeatherReportEntity> { resolve, reject in
            resolve(WeatherReportEntity(city: city, temperature: .fahrenheit(degrees: Double(arc4random_uniform(110) + 1))))
        }
    }
}
