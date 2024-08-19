import FirebaseAuth

public enum AuthError: Error {
    case noVerificationId
}

public struct User {
    public let uid: String
}

enum UserDefaultKey: String {
    case authVerificationId
}

public protocol AuthService {
    var isAuthenticated: Bool { get }
    
    func requestOTP(forPhoneNumber phoneNumber: String) async throws
    func authenticate(with otp: String) async throws -> User
}

public class AuthServiceLive: AuthService {
    
    public var isAuthenticated: Bool {
        Auth.auth().currentUser != nil
    }
    
    public init() {}

    public func requestOTP(forPhoneNumber phoneNumber: String) async throws {
        let verificationID = try await PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil)
        
        UserDefaults.standard.set(verificationID, forKey: UserDefaultKey.authVerificationId.rawValue)
    }
    
    public func authenticate(with otp: String) async throws -> User {
        
        guard let verificationId = UserDefaults.standard.string(forKey: UserDefaultKey.authVerificationId.rawValue) else {
            throw AuthError.noVerificationId
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: otp
        )
        
        let result = try await Auth.auth().signIn(with: credential)
        
        return User(uid: result.user.uid)
    }
}
