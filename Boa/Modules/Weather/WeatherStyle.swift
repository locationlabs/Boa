import UIKit


protocol WeatherStyleType {
    func styleGradientLayer(gradientLayer: CAGradientLayer, forTemparture temperature: Temperature)
    func styleCityNameLabel(label: UILabel, forTemparture temperature: Temperature)
    func styleTemparatureLabel(label: UILabel, forTemparture temperature: Temperature)
    func styleNavigationBar(navigationBar: UINavigationBar)
    func styleAddBarButtonItem(barButtonItem: UIBarButtonItem)
    func styleFooterView(view: WeatherTableFooterView, isCelcius: Bool) 
}

// MARK: - WeatherStyleType
struct WeatherStyle: WeatherStyleType, BaseStyleType {

    func styleGradientLayer(gradientLayer: CAGradientLayer, forTemparture temperature: Temperature) {
        gradientLayer.colors =  [
            temperature.startColor.CGColor,
            temperature.endColor.CGColor
        ]
    }
    
    func styleCityNameLabel(label: UILabel, forTemparture temperature: Temperature) {
        label.font = UIFont(name: "AvenirNext-Regular", size: 32.0)
        label.textColor = temperature.textColor
    }
    
    func styleTemparatureLabel(label: UILabel, forTemparture temperature: Temperature) {
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 54.0)
        label.textColor = temperature.textColor
    }

    func styleNavigationBar(navigationBar: UINavigationBar) {
        navigationBar.barTintColor = .blackColor()
        navigationBar.tintColor = .whiteColor()
        navigationBar.translucent = false
        navigationBar.barStyle = .Black
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20.0)!
        ]
    }
    
    func styleAddBarButtonItem(barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = .whiteColor()
        barButtonItem.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17.0)!
        ], forState: .Normal)
    }
    
    func styleFooterView(view: WeatherTableFooterView, isCelcius: Bool) {
        let title = NSMutableAttributedString(string: "f / c", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        var range: NSRange
        if isCelcius {
            range = NSRange(location: 4, length: 1)
        } else {
            range = NSRange(location: 0, length: 1)
        }
        
        title.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range)
        
        view.weatherFormat.setAttributedTitle(title, forState: UIControlState.Normal)
        
        view.addButton.setImage(UIImage(named:"PlusIcon")?.withTint(.whiteColor()), forState: .Normal)
    }
}
