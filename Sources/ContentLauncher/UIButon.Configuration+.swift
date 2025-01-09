import UIKit

extension UIButton.Configuration {
    @MainActor
    static func lancher() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .label
        configuration.background.visualEffect = UIBlurEffect(style: .systemMaterial)
        configuration.background.backgroundColor = .clear
        configuration.background.strokeWidth = 1
        configuration.background.strokeOutset = 1
        configuration.background.strokeColor = .white.withAlphaComponent(0.3)
        configuration.cornerStyle = .capsule
        if #available(iOS 18.0, *) {
            configuration.background.shadowProperties.opacity = 0.75
            configuration.background.shadowProperties.radius = 50
        }
        return configuration
    }
}

