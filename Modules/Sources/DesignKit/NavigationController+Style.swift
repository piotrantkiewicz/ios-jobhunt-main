import UIKit

public extension UINavigationController {
    static func styleJobHunt() {
        let appearance = UINavigationBar.appearance()

        appearance.tintColor = .accent

        let image = UIImage(resource: .angleArrowLeft)

        appearance.backIndicatorImage = image
        appearance.backIndicatorTransitionMaskImage = image

        appearance.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
