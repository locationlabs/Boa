import UIKit


final class AddCityViewController: UIViewController {
    
    var presenter: AddCityPresenterViewType!
    var styler: AddCityStyleType!
    
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
    }
    
    @IBAction func doCancel(_ sender: AnyObject) {
        presenter.requestDismiss()
    }
    
    @IBAction func doAdd(_ sender: AnyObject) {
        
    }
}

protocol AddCityViewType: class {
    
}

// MARK: - AddCityViewType
extension AddCityViewController: AddCityViewType {
   
}

// MARK: - Private
private extension AddCityViewController {
   func applyStyles() {
        
    }
}

