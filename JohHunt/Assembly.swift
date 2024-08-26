import Foundation
import JHAccount
import JHAuth
import Swinject

final class Assembly {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func assemble() {
        let authService = AuthServiceLive()
        let userRepository = UserProfileRepositoryLive(authService: authService)
        let profilePictureRepository = ProfilePictureRepositoryLive(
            authService: authService,
            userProfileRepository: userRepository
        )
        
        container.register(AuthService.self) { _ in
            authService
        }
        
        container.register(UserProfileRepository.self) { _ in
            userRepository
        }
        
        container.register(ProfilePictureRepository.self) { _ in
            profilePictureRepository
        }
    }
}




