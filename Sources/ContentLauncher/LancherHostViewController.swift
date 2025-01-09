import UIKit
import SwiftUI

final class LancherHostViewController<Content: View>: UIViewController {
    let button = UIButton(configuration: .lancher())
    let content: Content
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        button.configuration?.image = UIImage(systemName: "terminal")
        view.addSubview(button)
        
        button.addAction(UIAction { [unowned self] _ in
            presentContent()
        }, for: .primaryActionTriggered)
        
        button.addInteraction(LancherButtonInteraction())
    }
    
    func presentContent() {
        let vc = UIHostingController(rootView: content)
        vc.sheetPresentationController?.detents = [.medium(), .large()]
        vc.sheetPresentationController?.selectedDetentIdentifier = .medium
        vc.sheetPresentationController?.prefersGrabberVisible = true
        
        vc.sheetPresentationController?.prefersEdgeAttachedInCompactHeight = true
        vc.sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        
        present(vc, animated: true)
    }
}
