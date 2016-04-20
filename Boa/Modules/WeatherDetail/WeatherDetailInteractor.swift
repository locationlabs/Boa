

final class WeatherDetailInteractor {
    
    weak var presenter: WeatherDetailPresenterInteractorType?
    let dataManager: WeatherDetailDataManagerType
    
    init(presenter: WeatherDetailPresenterInteractorType, dataManager: WeatherDetailDataManagerType) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

protocol WeatherDetailInteractorType: class {

}

// MARK: - WeatherDetailInteractorType
extension WeatherDetailInteractor: WeatherDetailInteractorType {

}
