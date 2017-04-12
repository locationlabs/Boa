import PromiseKit


final class WeatherDataManager {
    
    let cityService: CityServiceType
    let weatherService: WeatherServiceType
    
    init(cityService: CityServiceType, weatherService: WeatherServiceType) {
        self.cityService = cityService
        self.weatherService = weatherService
    }
}

protocol WeatherDataManagerType: class {
    func fetchCities() -> Promise<[CityEntity]>
    func fetchWeatherReportForCity(_ city: CityEntity) -> Promise<WeatherReportEntity>
}

// MARK: - WeatherDataManagerType
extension WeatherDataManager: WeatherDataManagerType {
   
    func fetchCities() -> Promise<[CityEntity]> {
        return cityService.fetchCities()
    }
    
    func fetchWeatherReportForCity(_ city: CityEntity) -> Promise<WeatherReportEntity> {
        return weatherService.fetchWeatherReportForCity(city: city)
    }
}
