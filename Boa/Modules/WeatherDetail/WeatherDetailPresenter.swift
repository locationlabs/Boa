


final class WeatherDetailPresenter {
    
    var router: WeatherDetailRouterType!
    var interactor: WeatherDetailInteractorType!
    weak var view: WeatherPageViewType?
    
    init(view: WeatherPageViewType) {
        self.view = view
    }
}

protocol WeatherDetailPresenterViewType: class {
    func requestListView()
}

// MARK: - WeatherDetailPresenterViewType
extension WeatherDetailPresenter: WeatherDetailPresenterViewType {
    func requestListView() {
        router.dismiss()
    }
}

protocol WeatherDetailPresenterInteractorType: class {

}

// MARK: - WeatherDetailPresenterInteractorType
extension WeatherDetailPresenter: WeatherDetailPresenterInteractorType {

}
