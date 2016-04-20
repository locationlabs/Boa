import UIKit
import Cobra


final class AddCityRouter {
    
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol AddCityRouterType: class {
    func dismiss()
}

// MARK: - AddCityRouterType
extension AddCityRouter: AddCityRouterType {
    
    func dismiss() {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
