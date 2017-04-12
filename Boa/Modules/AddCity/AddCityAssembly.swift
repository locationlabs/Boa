import UIKit
import Swinject
import SwinjectStoryboard
import Cobra


final class AddCityAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension AddCityAssembly: Assembly {

    func assemble(container: Container) {
        
        // feature
        container.register(AddCityFeatureType.self) { resolver in
            return AddCityFeature(storyboard: resolver.resolve(SwinjectStoryboard.self, name: "AddCity")!)
        }

        // styles
        container.register(AddCityStyleType.self) { resolver in
            return AddCityStyle()
        }
        
        // router
        container.register(AddCityRouter.self) { _, controller in
            return AddCityRouter(controller: controller)
        }

        // storyboard
        container.register(SwinjectStoryboard.self, name: "AddCity") { _ in
            return SwinjectStoryboard.create(name: "AddCity", bundle: Bundle(for: AddCityAssembly.self), container: container)
        }
        
        // view controller
        container.storyboardInitCompleted(AddCityViewController.self, name: "AddCity") { resolver, controller in
            controller.presenter = resolver.resolve(AddCityPresenter.self, argument: controller as AddCityViewType)
            controller.styler = resolver.resolve(AddCityStyleType.self)
        }
        
        // presenter
        container.register(AddCityPresenter.self) { _, view in
            return AddCityPresenter(view: view)
        }.initCompleted { resolver, presenter in
            presenter.interactor = resolver.resolve(AddCityInteractor.self, argument: presenter as AddCityPresenterInteractorType)
            presenter.router = resolver.resolve(AddCityRouter.self, argument: presenter.view as! UIViewController)
        }
        
        // interator
        container.register(AddCityInteractor.self) { resolver, presenter in
            return AddCityInteractor(presenter: presenter, 
                                                dataManager: resolver.resolve(AddCityDataManager.self)!)
        }
        
        // data manager
        container.register(AddCityDataManager.self) { _ in
            return AddCityDataManager()
        }
    }

    func loaded(_ resolver: Resolver) {

    }
}
