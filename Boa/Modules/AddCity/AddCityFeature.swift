import UIKit


final class AddCityFeature {
    
    let storyboard: UIStoryboard
    
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
        let controller = storyboard.instantiateViewController(withIdentifier: "AddCity") as! AddCityViewController
        fromViewController.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}
