import UIKit
import DesignKit
import SnapKit

class AccountLogoutCell: UITableViewCell {
    
    struct Model {
        let icon: UIImage
        let title: String
    }
    
    private weak var stackView: UIStackView!
    private weak var optionLogo: UIImageView!
    private weak var optionTitle: UILabel!
    private weak var arrow: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with model: Model) {
        optionLogo.image = model.icon
        optionTitle.text = model.title
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupUI()
    }
}

extension AccountLogoutCell {
    
    private func setupUI() {
        backgroundColor = .clear
        setupStackView()
        setupIcon()
        setupTitle()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.spacing = 12
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.stackView = stackView
    }
    
    private func setupIcon() {
        let icon = UIImageView()
        
        stackView.addSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.optionLogo = icon
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.font = .title5
        title.textColor = .logout
        
        stackView.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.left.equalTo(optionLogo.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        self.optionTitle = title
    }
}








