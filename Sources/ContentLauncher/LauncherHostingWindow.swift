import SwiftUI
import UIKit

public final class LauncherHostingWindow<Content: View>: UIWindow {
    public init(
        windowScene: UIWindowScene,
        content: Content
    ) {
        super.init(windowScene: windowScene)
        rootViewController = LauncherHostViewController(content: content)
        isHidden = false // visibleWithoutMakeKey
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isModelPresented: Bool {
        rootViewController?.presentedViewController != nil
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isModelPresented {
            return super.hitTest(point, with: event)
        } else {
            let hitTestResult = super.hitTest(point, with: event)
            if hitTestResult is UIButton {
                return hitTestResult
            } else {
                return nil
            }
        }
    }
}

@available(*, deprecated, renamed: "LauncherHostingWindow", message: "Use LauncherHostingWindow instead.")
public typealias LancherHostingWindow = LauncherHostingWindow
