import UIKit
import DesignKit
import SnapKit

class ProfileEditPictureCell: UITableViewCell {
    
    private var companyImageLbl: UILabel!
    private var companyImageView: UIImageView!
    private var changeCompanyImageBtn: UIButton!
    
    var didTap: (()->())?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupUI()
    }
}

extension ProfileEditPictureCell {
    
    private func setupUI() {
        setupCompanyImageLbl()
        setupChangeCompanyImageBtn()
        setupImageView()
    }
    
    private func setupCompanyImageLbl() {
        let label = UILabel()
        label.text = ProfileEditStrings.companyImageLbl.rawValue
        label.font = .title2
        label.tintColor = .primary
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        
        self.companyImageLbl = label
    }
    
    private func setupChangeCompanyImageBtn() {
        let button = UIButton()
        button.titleLabel?.font = .button2
        button.setTitleColor(.accent, for: .normal)
        button.setTitleColor(.accent, for: .highlighted)
        button.setTitleColor(.accent, for: .selected)
        button.setTitle(ProfileEditStrings.changeCompanyImage.rawValue, for: .normal)
        button.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview()
        }
        
        self.changeCompanyImageBtn = button
    }
    
    private func setupImageView() {
        let image = UIImageView()
        image.image = UIImage(resource: .profilePicture)
        image.layer.cornerRadius = 60
        image.layer.masksToBounds = true
        
        contentView.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(36)
        }
        
        self.companyImageView = image
    }
    
    @objc
    private func didTapBtn() {
        didTap?()
    }
}











