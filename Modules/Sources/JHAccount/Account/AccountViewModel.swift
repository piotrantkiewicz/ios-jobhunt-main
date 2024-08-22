import UIKit

public final class AccountViewModel {
    
    struct Header {
        let image: UIImage
        let companyName: String
        let location: String
    }
    
    let header: Header
    
    public init() {
        header = Header(
            image: UIImage(resource: .user),
            companyName: "Company",
            location: "Location not specified"
        )
    }
}

extension AccountOptionCell.Model {
    static func notification(text: String? = nil) -> Self {
        Self(
            icon: UIImage(resource: .bell),
            title: "Notification"
        )
    }
    static func theme(text: String? = nil) -> Self {
        Self(
            icon: UIImage(resource: .moon),
            title: "Theme"
        )
    }
    static func helpCenter(text: String? = nil) -> Self {
        Self(
            icon: UIImage(resource: .message),
            title: "Help Center"
        )
    }
    static func rateOurApp(text: String? = nil) -> Self {
        Self(
            icon: UIImage(resource: .star),
            title: "Rate Our App"
        )
    }
    static func termOfService(text: String? = nil) -> Self {
        Self(
            icon: UIImage(resource: .notes),
            title: "Term Of Service"
        )
    }
}

extension AccountLogoutCell.Model {
    static func logout(text: String? = nil) -> Self {
        Self(
            icon: UIImage(resource: .logout),
            title: "Logout"
        )
    }
}
