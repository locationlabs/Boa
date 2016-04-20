import UIKit


final class AddCityFeature {
    
    private let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol AddCityFeatureType: class {
    func showFromViewController(fromViewController: UIViewController)
}

// MARK: - AddCityFeatureType
extension AddCityFeature: AddCityFeatureType {
   
    func showFromViewController(fromViewController: UIViewController) {
        let controller = storyboard.instantiateViewControllerWithIdentifier("AddCity") as! AddCityViewController
        fromViewController.presentViewController(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}
