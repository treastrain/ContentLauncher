import UIKit

final class LauncherButtonInteraction: NSObject, UIInteraction {
    weak var view: UIView?
    
    var centerXConstraint: NSLayoutConstraint!
    var centerYConstraint: NSLayoutConstraint!
    
    var trailingConstraint: NSLayoutConstraint!
    var leadingConstraint: NSLayoutConstraint!
    
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    let padding: CGFloat = 16
    
    func willMove(to view: UIView?) {
        self.view = view
    }
    
    func didMove(to view: UIView?) {
        guard let button = view else { return }
        guard let view = button.superview else { fatalError() }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        centerXConstraint = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerYConstraint = button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerYConstraint.priority = .defaultHigh
        
        leadingConstraint = button.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: padding
        )
        trailingConstraint = view.safeAreaLayoutGuide.trailingAnchor.constraint(
            equalTo: button.trailingAnchor,
            constant: padding
        )
        
        topConstraint = button.topAnchor.constraint(
            greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
            constant: padding
        )
        topConstraint.priority = .required
        bottomConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(
            greaterThanOrEqualTo: button.bottomAnchor,
            constant: padding
        )
        bottomConstraint.priority = .required
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            button.heightAnchor.constraint(equalTo: button.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            trailingConstraint,
            bottomConstraint,
        ])
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(onPan))
        button.addGestureRecognizer(panGesture)
    }
    
    @objc func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let view = self.view!.superview!
        
        let center = gestureRecognizer
            .location(in: view)
            .applying(CGAffineTransform(translationX: -view.bounds.width / 2, y: -view.bounds.height / 2))
        
        centerXConstraint.constant = center.x
        centerYConstraint.constant = center.y
        
        switch gestureRecognizer.state {
        case .began:
            centerXConstraint.isActive = true
            centerYConstraint.isActive = true
            
            trailingConstraint.isActive = false
            leadingConstraint.isActive = false
            
            topConstraint.isActive = false
            bottomConstraint.isActive = false
        case .ended, .failed, .cancelled:
            centerXConstraint.isActive = false
            if centerXConstraint.constant > 0 {
                trailingConstraint.isActive = true
            } else {
                leadingConstraint.isActive = true
            }
            
            topConstraint.isActive = true
            bottomConstraint.isActive = true
        default:
            break
        }
        
        UIView.animate(animations: {
            view.layoutIfNeeded()
        })
    }
}

