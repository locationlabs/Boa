import UIKit

final class EditCityFeature {
    
    private let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol EditCityFeatureType: class {
    func showFromViewController(fromViewController: UIViewController, isAdding: Bool)
}

// MARK: - EditCityFeatureType
extension EditCityFeature: EditCityFeatureType {
   
    func showFromViewController(fromViewController: UIViewController, isAdding: Bool) {
        let controller = storyboard.instantiateViewControllerWithIdentifier("EditCity") as! EditCityViewController
        controller.isAdding = isAdding
        fromViewController.presentViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}
