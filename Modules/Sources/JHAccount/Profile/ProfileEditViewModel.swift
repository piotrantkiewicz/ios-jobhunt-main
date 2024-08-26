import UIKit
import JHAuth

public final class ProfileEditViewModel {
    
    var selectedImage: UIImage?
    var companyName: String = ""
    var companyLocation: String = ""
    
    private let userRepository: UserProfileRepository
    
    init(userRepository: UserProfileRepository) {
        self.userRepository = userRepository
        
        if let profile = userRepository.profile {
            companyName = profile.companyName
            companyLocation = profile.companyLocation
        }
    }
    
    func save() throws {
        let profile = UserProfile(
            companyName: companyName,
            companyLocation: companyLocation
        )
        
        try userRepository.saveUserProfile(profile)
    }
}








