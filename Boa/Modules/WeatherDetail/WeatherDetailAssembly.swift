import UIKit
import Swinject
import SwinjectStoryboard
import Cobra


final class WeatherDetailAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension WeatherDetailAssembly: Assembly {

    func assemble(container: Container) {
        
        // feature
        container.register(WeatherDetailFeatureType.self) { resolver in
            return WeatherDetailFeature(storyboard: resolver.resolve(SwinjectStoryboard.self, name: "WeatherDetail")!)
        }

        // styles
        container.register(WeatherDetailStyleType.self) { resolver in
            return WeatherDetailStyle()
        }
        
        // router
        container.register(WeatherDetailRouter.self) { _, controller in
            return WeatherDetailRouter(controller: controller)
        }

        // storyboard
        container.register(SwinjectStoryboard.self, name: "WeatherDetail") { _ in
            return SwinjectStoryboard.create(name: "WeatherDetail", bundle: Bundle(for: WeatherDetailAssembly.self), container: container)
        }
        
        // view controller
        container.storyboardInitCompleted(WeatherPageViewController.self, name: "WeatherDetailPage") { resolver, controller in
            controller.presenter = resolver.resolve(WeatherDetailPresenter.self, argument: controller as WeatherPageViewType)
            controller.styler = resolver.resolve(WeatherDetailStyleType.self)
            controller.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
        
        // presenter
        container.register(WeatherDetailPresenter.self) { _, view in
            return WeatherDetailPresenter(view: view)
        }.initCompleted { resolver, presenter in
            presenter.interactor = resolver.resolve(WeatherDetailInteractor.self, argument: presenter as WeatherDetailPresenterInteractorType)
            presenter.router = resolver.resolve(WeatherDetailRouter.self, argument: presenter.view as! UIViewController)
        }
        
        // interator
        container.register(WeatherDetailInteractor.self) { resolver, presenter in
            return WeatherDetailInteractor(presenter: presenter, 
                                                dataManager: resolver.resolve(WeatherDetailDataManager.self)!)
        }
        
        // data manager
        container.register(WeatherDetailDataManager.self) { _ in
            return WeatherDetailDataManager()
        }
    }

    func loaded(_ resolver: Resolver) {

    }
}
