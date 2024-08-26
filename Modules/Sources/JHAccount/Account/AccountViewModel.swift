import UIKit
import JHAuth

public final class AccountViewModel {
    
    struct Header {
        let image: UIImage
        let companyName: String
        let location: String
    }
    
    var header: Header
    
    var didUpdateHeader: (() -> ())?
    
    let userRepository: UserProfileRepository
    
    public init(userRepository: UserProfileRepository) {
        self.userRepository = userRepository
        
        header = Header(
            image: UIImage(resource: .user),
            companyName: "Company",
            location: "Location not specified"
        )
    }
    
    func fetchUserProfile() {
        Task { [weak self] in
            do {
                guard let profile = try await self?.userRepository.fetchUserProfile()
                else { return }
                
                await MainActor.run { [weak self] in
                    self?.updateHeader(with: profile)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func updateHeader(with userProfile: UserProfile) {
        header = Header(
            image: UIImage(resource: .user),
            companyName: userProfile.companyName,
            location: userProfile.companyLocation
        )
        
        didUpdateHeader?()
    }
}

extension AccountOptionCell.Model {
    static var notification: Self {
        Self(
            icon: UIImage(resource: .bell),
            title: "Notification"
        )
    }
    static var theme: Self {
        Self(
            icon: UIImage(resource: .moon),
            title: "Theme"
        )
    }
    static var helpCenter: Self {
        Self(
            icon: UIImage(resource: .message),
            title: "Help Center"
        )
    }
    static var rateOurApp: Self {
        Self(
            icon: UIImage(resource: .star),
            title: "Rate Our App"
        )
    }
    static var termOfService: Self {
        Self(
            icon: UIImage(resource: .notes),
            title: "Term Of Service"
        )
    }
}

extension AccountLogoutCell.Model {
    static var logout: Self {
        Self(
            icon: UIImage(resource: .logout),
            title: "Logout"
        )
    }
}
