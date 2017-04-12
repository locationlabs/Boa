import UIKit

protocol FooterViewDelegate {
    func didPressAdd()
    func didPressWeatherFormatButton()
}

final class WeatherTableFooterView: UIView {
    
    var delegate: FooterViewDelegate!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var weatherFormat: UIButton!
    
    @IBAction func didPressAdd(_ sender: AnyObject) {
        delegate.didPressAdd()
    }
    
    @IBAction func didPresWeatherFormatButton(_ sender: AnyObject) {
        
        delegate.didPressWeatherFormatButton()
    }
}
