import UIKit


final class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var gradientLayer = CAGradientLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, atIndex: 0)
//        gradient.frame = imageView.bounds
//        gradient.colors = colorStyle.primaryGradientColors().map { $0.CGColor }
//        gradient.masksToBounds = true
//        gradient.mask = mask
//        imageView.layer.insertSublayer(gradient, atIndex: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
    }
}
