import UIKit


protocol WeatherStyleType {
    func styleGradientLayer(_ gradientLayer: CAGradientLayer, forTemparture temperature: Temperature)
    func styleCityNameLabel(_ label: UILabel, forTemparture temperature: Temperature)
    func styleTemparatureLabel(_ label: UILabel, forTemparture temperature: Temperature)
    func styleNavigationBar(_ navigationBar: UINavigationBar)
    func styleAddBarButtonItem(_ barButtonItem: UIBarButtonItem)
    func styleFooterView(_ view: WeatherTableFooterView, isCelcius: Bool) 
}

// MARK: - WeatherStyleType
struct WeatherStyle: WeatherStyleType, BaseStyleType {

    func styleGradientLayer(_ gradientLayer: CAGradientLayer, forTemparture temperature: Temperature) {
        gradientLayer.colors =  [
            temperature.startColor.cgColor,
            temperature.endColor.cgColor
        ]
    }
    
    func styleCityNameLabel(_ label: UILabel, forTemparture temperature: Temperature) {
        label.font = UIFont(name: "AvenirNext-Regular", size: 32.0)
        label.textColor = temperature.textColor
    }
    
    func styleTemparatureLabel(_ label: UILabel, forTemparture temperature: Temperature) {
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 54.0)
        label.textColor = temperature.textColor
    }

    func styleNavigationBar(_ navigationBar: UINavigationBar) {
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20.0)!
        ]
    }
    
    func styleAddBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = .white
        barButtonItem.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17.0)!
        ], for: UIControlState())
    }
    
    func styleFooterView(_ view: WeatherTableFooterView, isCelcius: Bool) {
        let title = NSMutableAttributedString(string: "f / c", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        
        var range: NSRange
        if isCelcius {
            range = NSRange(location: 4, length: 1)
        } else {
            range = NSRange(location: 0, length: 1)
        }
        
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
        
        view.weatherFormat.setAttributedTitle(title, for: UIControlState())
        
        view.addButton.setImage(UIImage(named:"PlusIcon")?.withTint(.white), for: UIControlState())
    }
}
