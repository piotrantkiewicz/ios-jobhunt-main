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
