import UIKit
import DesignKit
import SnapKit

class ProfileTextFieldCell: UITableViewCell {
    
    struct Model {
        let placeholder: String
        let header: String
        let text: String?
        
        init(
            placeholder: String,
            header: String,
            text: String? = nil
        ) {
            self.placeholder = placeholder
            self.header = header
            self.text = text
        }
    }
    
    weak var textField: UITextField!
    
    private weak var companyNameLbl: UILabel!
    private weak var containerView: UIView!
    private weak var spacer: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with model: Model) {
        textField.placeholder = model.placeholder
        textField.text = model.text
        companyNameLbl.text = model.header
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupUI()
    }
}

extension ProfileTextFieldCell {
    
    private func setupUI() {
        backgroundColor = .clear
        setupSpacer()
        setupContainer()
        setupCompanyNameLbl()
        setupTextField()
    }
    
    private func setupSpacer() {
        let view = UIView()
        view.backgroundColor = .spacer
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        self.spacer = view
    }
    
    private func setupContainer() {
        let view = UIView()
        view.backgroundColor = .secondary
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(56)
        }
        
        self.containerView = view
    }
    
    private func setupCompanyNameLbl() {
        let label = UILabel()
        label.textColor = .primary
        label.font = .subtitle3
        label.text = ProfileEditStrings.companyNameLbl.rawValue
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top).offset(-12)
            make.top.equalTo(spacer.snp.bottom).offset(24)
        }
        
        self.companyNameLbl = label
    }
    
    private func setupTextField() {
        let textField = UITextField()
        textField.textColor = .subtitleText
        textField.font = .textField
        
        containerView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        self.textField = textField
    }
}








