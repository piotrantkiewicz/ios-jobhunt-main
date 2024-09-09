import UIKit
import JHAuth
import Swinject

public final class PhoneNumberViewModel {
    
    let container: Container
    let authService: AuthService
    
    public init(container: Container) {
        self.container = container
        self.authService = container.resolve(AuthService.self)!
    }
    
    public func requestOTP(with phoneNumber: String) async throws{
        try await authService.requestOTP(forPhoneNumber: phoneNumber)
    }
}
