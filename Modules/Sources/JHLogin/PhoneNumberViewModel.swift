import UIKit
import JHAuth

public final class PhoneNumberViewModel {
    
    let authService: AuthService
    
    public init(authService: AuthService) {
        self.authService = authService
    }
    
    public func requestOTP(with phoneNumber: String) async throws{
        try await authService.requestOTP(forPhoneNumber: phoneNumber)
    }
}
