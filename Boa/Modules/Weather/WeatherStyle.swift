import UIKit


final class WeatherStyle {
    
}

protocol WeatherStyleType: class {
    func styleGradientLayer(gradientLayer: CAGradientLayer, forTemparture temparture: Temparture)
    func styleCityNameLabel(label: UILabel, forTemparture temparture: Temparture)
    func styleTemparatureLabel(label: UILabel, forTemparture temparture: Temparture)
    func styleNavigationBar(navigationBar: UINavigationBar)
    func styleAddBarButtonItem(barButtonItem: UIBarButtonItem)
}

// MARK: - WeatherStyleType
extension WeatherStyle: WeatherStyleType {

    func styleGradientLayer(gradientLayer: CAGradientLayer, forTemparture temparture: Temparture) {
        gradientLayer.colors =  [
            temparture.startColor.CGColor,
            temparture.endColor.CGColor
        ]
    }
    
    func styleCityNameLabel(label: UILabel, forTemparture temparture: Temparture) {
        label.font = UIFont(name: "AvenirNext-Regular", size: 32.0)
        label.textColor = temparture.textColor
    }
    
    func styleTemparatureLabel(label: UILabel, forTemparture temparture: Temparture) {
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 54.0)
        label.textColor = temparture.textColor
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
}
