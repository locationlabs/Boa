import UIKit
import Swinject
import Cobra


final class WeatherAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension WeatherAssembly: AssemblyType {

    func assemble(container: Container) {
        
        // feature
        container.register(WeatherFeatureType.self) { resolver in
            return WeatherFeature(storyboard: resolver.resolve(SwinjectStoryboard.self, name: "Weather")!)
        }

        // styles
        container.register(WeatherStyleType.self) { resolver in
            return WeatherStyle()
        }
        
        // router
        container.register(WeatherRouter.self) { _, controller in
            return WeatherRouter(controller: controller)
        }

        // storyboard
        container.register(SwinjectStoryboard.self, name: "Weather") { _ in
            return SwinjectStoryboard.create(name: "Weather", bundle: NSBundle(forClass: WeatherAssembly.self), container: container)
        }
        
        // view controller
        container.registerForStoryboard(WeatherViewController.self, name: "Weather") { resolver, controller in
            controller.presenter = resolver.resolve(WeatherPresenter.self, argument: controller as WeatherViewType)
            controller.styler = resolver.resolve(WeatherStyleType.self)
        }
        
        // presenter
        container.register(WeatherPresenter.self) { _, view in
            return WeatherPresenter(view: view)
        }.initCompleted { resolver, presenter in
            presenter.interactor = resolver.resolve(WeatherInteractor.self, argument: presenter as WeatherPresenterInteractorType)
            presenter.router = resolver.resolve(WeatherRouter.self, argument: presenter.view as! UIViewController)
        }
        
        // interator
        container.register(WeatherInteractor.self) { resolver, presenter in
            return WeatherInteractor(presenter: presenter, 
                                                dataManager: resolver.resolve(WeatherDataManager.self)!)
        }
        
        // data manager
        container.register(WeatherDataManager.self) { resolver in
            return WeatherDataManager(cityService: resolver.resolve(CityServiceType.self)!,
                                     weatherService: resolver.resolve(WeatherServiceType.self)!)
        }
    }

    func loaded(resolver: ResolverType) {

    }
}
