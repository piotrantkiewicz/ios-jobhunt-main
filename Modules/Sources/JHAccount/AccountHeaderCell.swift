import UIKit
import DesignKit
import SDWebImage
import SnapKit

class AccountHeaderCell: UITableViewCell {
    
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var companyImageView: UIImageView!
    private var companyLbl: UILabel!
    private var locationLbl: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with viewModel: AccountViewModel.Header) {
        companyImageView.image = viewModel.image
        companyLbl.text = viewModel.companyName
        locationLbl.text = viewModel.location
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupUI()
    }
}

extension AccountHeaderCell {
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupContainer()
        setupStackView()
        setupImageView()
        setupLabels()
        setupIndicator()
    }
    
    private func setupContainer() {
        let view = UIView()
        view.backgroundColor = .secondary
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        contentView.addSubview(view)
        
        self.containerView = view
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(88)
        }
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        
        containerView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(resource: .user)
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        self.companyImageView = imageView
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        let companyLbl = setupCompanyLbl()
        labelsStackView.addArrangedSubview(companyLbl)
        self.companyLbl = companyLbl
        
        let locationLbl = setupLocationLbl()
        labelsStackView.addArrangedSubview(locationLbl)
        self.locationLbl = locationLbl
        
        self.stackView.addArrangedSubview(labelsStackView)
    }
    
    private func setupCompanyLbl() -> UILabel {
        let companyLbl = UILabel()
        companyLbl.font = .title2
        companyLbl.textColor = .primary
        return companyLbl
    }
    
    private func setupLocationLbl() -> UILabel {
        let locationLbl = UILabel()
        locationLbl.font = .subtitle2
        locationLbl.textColor = .subtitleText
        return locationLbl
    }
    
    private func setupIndicator() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .arrowRight
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
}
