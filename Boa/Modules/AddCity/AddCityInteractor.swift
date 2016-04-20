

final class AddCityInteractor {
    
    weak var presenter: AddCityPresenterInteractorType?
    let dataManager: AddCityDataManagerType
    
    init(presenter: AddCityPresenterInteractorType, dataManager: AddCityDataManagerType) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

protocol AddCityInteractorType: class {

}

// MARK: - AddCityInteractorType
extension AddCityInteractor: AddCityInteractorType {

}
