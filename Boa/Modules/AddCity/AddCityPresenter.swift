


final class AddCityPresenter {
    
    var router: AddCityRouterType!
    var interactor: AddCityInteractorType!
    weak var view: AddCityViewType?
    
    init(view: AddCityViewType) {
        self.view = view
    }
}

protocol AddCityPresenterViewType: class {
    func requestDismiss()
}

// MARK: - AddCityPresenterViewType
extension AddCityPresenter: AddCityPresenterViewType {
    func requestDismiss() {
        router.dismiss()
    }
}

protocol AddCityPresenterInteractorType: class {

}

// MARK: - AddCityPresenterInteractorType
extension AddCityPresenter: AddCityPresenterInteractorType {

}
