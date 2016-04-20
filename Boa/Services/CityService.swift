import PromiseKit


final class CityService {
    
}

protocol CityServiceType: class {
    func fetchCities() -> Promise<[CityEntity]>
}

// MARK: - CityServiceType
extension CityService: CityServiceType {
    func fetchCities() -> Promise<[CityEntity]> {
        return Promise<[CityEntity]> { resolve, reject in
            resolve([
                CityEntity(name: "Chicago"),
                CityEntity(name: "New York"),
                CityEntity(name: "San Francisco"),
                CityEntity(name: "Boston"),
                CityEntity(name: "Miami"),
                CityEntity(name: "London"),
                CityEntity(name: "Tokyo"),
                CityEntity(name: "Las Vegas"),
                CityEntity(name: "Honolulu"),
                CityEntity(name: "Philadelphia")
            ])
        }
    }
}

