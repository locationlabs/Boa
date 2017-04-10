import UIKit


final class AddCityFeature {
    
    fileprivate let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
}

protocol AddCityFeatureType: class {
    func showFromViewController(_ fromViewController: UIViewController)
}

// MARK: - AddCityFeatureType
extension AddCityFeature: AddCityFeatureType {
   
    func showFromViewController(_ fromViewController: UIViewController) {
        let controller = storyboard.instantiateViewController(withIdentifier: "AddCity") as! AddCityViewController
        fromViewController.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}
