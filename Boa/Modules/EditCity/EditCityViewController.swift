import UIKit

final class EditCityViewController: UIViewController {
    
    var presenter: EditCityPresenterViewType!
    var styler: EditCityStyleType!
    var isAdding: Bool?
    
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
        
        if isAdding != nil && isAdding! {
            editBarButtonItem.title = "Add"
        }
    }
    
    @IBAction func doCancel(sender: AnyObject) {
        presenter.requestDismiss()
    }
    
    @IBAction func doAdd(sender: AnyObject) {
        
    }
}

protocol EditCityViewType: class {
    
}

// MARK: - EditCityViewType
extension EditCityViewController: EditCityViewType {
   
}

// MARK: - Private
private extension EditCityViewController {
   func applyStyles() {
        
    }
}

