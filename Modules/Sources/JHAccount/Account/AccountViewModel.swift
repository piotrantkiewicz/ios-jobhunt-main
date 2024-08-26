import UIKit
import JHAuth

public final class AccountViewModel {
    
    struct Header {
        let imageUrl: URL?
        let companyName: String
        let location: String
    }
    
    var header: Header
    
    var didUpdateHeader: (() -> ())?
    
    let userRepository: UserProfileRepository
    let profilePictureRepository: ProfilePictureRepository
    
    public init(
        userRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
        self.userRepository = userRepository
        self.profilePictureRepository = profilePictureRepository
        
        header = Header(
            imageUrl: nil,
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
            imageUrl: userProfile.profilePictureUrl,
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
