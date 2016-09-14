


final class EditCityPresenter {
    
    var router: EditCityRouterType!
    var interactor: EditCityInteractorType!
    weak var view: EditCityViewType?
    
    init(view: EditCityViewType) {
        self.view = view
    }
}

protocol EditCityPresenterViewType: class {
    func requestDismiss()
}

// MARK: - EditCityPresenterViewType
extension EditCityPresenter: EditCityPresenterViewType {
    func requestDismiss() {
        router.dismiss()
    }
}

protocol EditCityPresenterInteractorType: class {

}

// MARK: - EditCityPresenterInteractorType
extension EditCityPresenter: EditCityPresenterInteractorType {

}
