import UIKit
import DesignKit
import SnapKit

class ProfileSaveChangesCell: UITableViewCell {
    
    private weak var saveChangesBtn: UIButton!
    
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

extension ProfileSaveChangesCell {
    
    private func setupUI() {
        setupSaveChangesBtn()
    }
    
    private func setupSaveChangesBtn() {
        let button = UIButton()
        button.titleLabel?.font = .button
        button.backgroundColor = .accent
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitleColor(.white, for: .selected)
        button.setTitle(ProfileEditStrings.saveChangesBtn.rawValue, for: .normal)
        button.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.saveChangesBtn = button
    }
    
    @objc
    private func didTapBtn() {
        didTap?()
    }
}








