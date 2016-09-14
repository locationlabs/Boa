import UIKit
import Swinject
import Cobra


final class EditCityAssembly: Constructible {
    required init() {}
}

// MARK: - AssemblyType
extension EditCityAssembly: AssemblyType {

    func assemble(container: Container) {
        
        // feature
        container.register(EditCityFeatureType.self) { resolver in
            return EditCityFeature(storyboard: resolver.resolve(SwinjectStoryboard.self, name: "EditCity")!)
        }

        // styles
        container.register(EditCityStyleType.self) { resolver in
            return EditCityStyle()
        }
        
        // router
        container.register(EditCityRouter.self) { _, controller in
            return EditCityRouter(controller: controller)
        }

        // storyboard
        container.register(SwinjectStoryboard.self, name: "EditCity") { _ in
            return SwinjectStoryboard.create(name: "EditCity", bundle: NSBundle(forClass: EditCityAssembly.self), container: container)
        }
        
        // view controller
        container.registerForStoryboard(EditCityViewController.self, name: "EditCity") { resolver, controller in
            controller.presenter = resolver.resolve(EditCityPresenter.self, argument: controller as EditCityViewType)
            controller.styler = resolver.resolve(EditCityStyleType.self)
        }
        
        // presenter
        container.register(EditCityPresenter.self) { _, view in
            return EditCityPresenter(view: view)
        }.initCompleted { resolver, presenter in
            presenter.interactor = resolver.resolve(EditCityInteractor.self, argument: presenter as EditCityPresenterInteractorType)
            presenter.router = resolver.resolve(EditCityRouter.self, argument: presenter.view as! UIViewController)
        }
        
        // interator
        container.register(EditCityInteractor.self) { resolver, presenter in
            return EditCityInteractor(presenter: presenter, 
                                                dataManager: resolver.resolve(EditCityDataManager.self)!)
        }
        
        // data manager
        container.register(EditCityDataManager.self) { _ in
            return EditCityDataManager()
        }
    }

    func loaded(resolver: ResolverType) {

    }
}
