import UIKit
import JHAuth

public final class ProfileEditViewModel {
    
    var selectedImage: UIImage?
    var companyName: String = ""
    var companyLocation: String = ""
    var profilePictureUrl: URL? = nil
    
    private let userRepository: UserProfileRepository
    private let profilePictureRepository: ProfilePictureRepository
    
    init(
        userRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
        self.userRepository = userRepository
        self.profilePictureRepository = profilePictureRepository
        
        if let profile = userRepository.profile {
            companyName = profile.companyName
            companyLocation = profile.companyLocation
            profilePictureUrl = profile.profilePictureUrl
        }
    }
    
    func save() async throws {
        let profile = UserProfile(
            companyName: companyName,
            companyLocation: companyLocation
        )
        
        try userRepository.saveUserProfile(profile)
        
        if let selectedImage {
            try await profilePictureRepository.upload(selectedImage)
        }
    }
}








