

/**
The WeatherReportEntity represents the weather report for a city
*/
struct WeatherReportEntity {
    
    let city: CityEntity
    var temperature: Temperature
    
    init(city: CityEntity, temperature: Temperature) {
        self.city = city
        self.temperature = temperature
    }
}

// MARK: - CustomStringConvertible
extension WeatherReportEntity: CustomStringConvertible {
   var description: String {
      return "{city=\(city), temparture=\(temperature)}"
   }
}
