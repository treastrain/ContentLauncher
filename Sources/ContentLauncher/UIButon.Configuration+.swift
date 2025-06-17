import UIKit

extension UIButton.Configuration {
    @MainActor
    public static func launcher() -> UIButton.Configuration {
        let legacyConfiguration = {
            var configuration: UIButton.Configuration = .plain()
            configuration.baseForegroundColor = .label
            configuration.background.visualEffect = UIBlurEffect(style: .systemMaterial)
            configuration.background.backgroundColor = .clear
            configuration.background.strokeWidth = 1
            configuration.background.strokeOutset = 1
            configuration.background.strokeColor = .white.withAlphaComponent(0.3)
            if #available(iOS 18.0, *) {
                configuration.background.shadowProperties.opacity = 0.75
                configuration.background.shadowProperties.radius = 50
            }
            configuration.cornerStyle = .capsule
            return configuration
        }
        
        var configuration: UIButton.Configuration
        #if compiler(>=6.2)
        if #available(iOS 19.0, *) {
            configuration = .glass()
            configuration.image = UIImage(systemName: "terminal")
        } else {
            configuration = legacyConfiguration()
        }
        #else
        configuration = legacyConfiguration()
        #endif
        
        configuration.image = UIImage(systemName: "terminal")
        
        return configuration
    }
}

