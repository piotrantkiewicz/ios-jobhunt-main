import UIKit

public enum Fonts: String {
    case urbanistBold = "Urbanist-Bold"
    case urbanistRegular = "Urbanist-Regular"
    case urbanistMedium = "Urbanist-Medium"
}

public extension UIFont {
    
    static var title: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 36)!
    }
    
    static var title2: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 18)!
    }
    
    static var title3: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 28)!
    }
    
    static var title4: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 20)!
    }
    
    static var title5: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 16)!
    }
    
    static var subtitle: UIFont {
        UIFont(name: Fonts.urbanistMedium.rawValue, size: 16)!
    }
    
    static var subtitle2: UIFont {
        UIFont(name: Fonts.urbanistRegular.rawValue, size: 14)!
    }
    
    static var subtitle3: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 14)!
    }
    
    static var textField: UIFont {
        UIFont(name: Fonts.urbanistMedium.rawValue, size: 16)!
    }
    
    static var button: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 16)!
    }
    
    static var button2: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 14)!
    }
    
    static var otpTitle: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 32)!
    }
    
    static var otp: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 16)!
    }
    
    static var otpTextField: UIFont {
        UIFont(name: Fonts.urbanistBold.rawValue, size: 24)!
    }
    
}
