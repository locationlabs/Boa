


final class WeatherDetailPresenter {
    
    var router: WeatherDetailRouterType!
    var interactor: WeatherDetailInteractorType!
    weak var view: WeatherDetailViewType?
    
    init(view: WeatherDetailViewType) {
        self.view = view
    }
}

protocol WeatherDetailPresenterViewType: class {

}

// MARK: - WeatherDetailPresenterViewType
extension WeatherDetailPresenter: WeatherDetailPresenterViewType {

}

protocol WeatherDetailPresenterInteractorType: class {

}

// MARK: - WeatherDetailPresenterInteractorType
extension WeatherDetailPresenter: WeatherDetailPresenterInteractorType {

}
