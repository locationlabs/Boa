import UIKit
import Cobra


final class EditCityRouter {
    
    weak var controller: UIViewController!
    
    init(controller: UIViewController) {
        self.controller = controller
    }
}

protocol EditCityRouterType: class {
    func dismiss()
}

// MARK: - EditCityRouterType
extension EditCityRouter: EditCityRouterType {
    
    func dismiss() {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
