

final class EditCityInteractor {
    
    weak var presenter: EditCityPresenterInteractorType?
    let dataManager: EditCityDataManagerType
    
    init(presenter: EditCityPresenterInteractorType, dataManager: EditCityDataManagerType) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

protocol EditCityInteractorType: class {

}

// MARK: - EditCityInteractorType
extension EditCityInteractor: EditCityInteractorType {

}
