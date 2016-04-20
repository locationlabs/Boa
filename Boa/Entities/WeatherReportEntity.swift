

/**
The WeatherReportEntity represents the weather report for a city
*/
final class WeatherReportEntity {
    
    let city: CityEntity
    var temparture: Temparture
    
    init(city: CityEntity, temparture: Temparture) {
        self.city = city
        self.temparture = temparture
    }
}

// MARK: - CustomStringConvertible
extension WeatherReportEntity: CustomStringConvertible {
   var description: String {
      return "{city=\(city), temparture=\(temparture)}"
   }
}
