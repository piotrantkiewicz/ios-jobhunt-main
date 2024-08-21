import UIKit
import SnapKit

public final class ProfileEditViewController: UIViewController {
    
    enum Row: Int, CaseIterable {
        case profilePicture
        case companyName
        case saveChanges
    }
    
    private weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupNavigationTitle()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileEditPictureCell.self, forCellReuseIdentifier: ProfileEditPictureCell.identifier)
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileTextFieldCell.identifier)
        tableView.register(ProfileSaveChangesCell.self, forCellReuseIdentifier: ProfileSaveChangesCell.identifier)
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Edit profile"
        titleLabel.font = .title4
        titleLabel.textColor = .primary
        navigationItem.titleView = titleLabel
    }
}

extension ProfileEditViewController {
    private func setupUI() {
        configureNavigationItem()
        setupTableView()
    }
    
    private func configureNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.tableView = tableView
    }
}

extension ProfileEditViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Row.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch row {
            
        case .profilePicture:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditPictureCell.identifier, for: indexPath) as? ProfileEditPictureCell else { return UITableViewCell() }
            
            cell.didTap = { [weak self] in
                self?.didTapProfilePicture()
            }
            
            return cell
            
        case .companyName:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextFieldCell.identifier, for: indexPath) as? ProfileTextFieldCell else { return UITableViewCell() }
            
            cell.configure(with: .companyName())
            
            return cell
            
        case .saveChanges:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSaveChangesCell.identifier, for: indexPath) as? ProfileSaveChangesCell else { return UITableViewCell() }
            
            cell.didTap = { [weak self] in
                self?.didSaveChanges()
            }
            
            return cell
        }
    }
}

extension ProfileTextFieldCell.Model {
    
    static func companyName(text: String? = nil) -> Self {
        Self(
            placeholder: ProfileEditStrings.companyNamePlaceholder.rawValue,
            header: ProfileEditStrings.companyNameLbl.rawValue,
            text: text
        )
    }
}

extension ProfileEditViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Row(rawValue: indexPath.row)! {
        case .profilePicture:
            return 156
        case .companyName:
            return 140
        case .saveChanges:
            return 56
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Row(rawValue: indexPath.row) {
        case .profilePicture:
            didTapProfilePicture()
        case .saveChanges:
            didSaveChanges()
        default:
            break
        }
    }
    
    private func didTapProfilePicture() {
        print("didTapProfilePicture")
    }
    
    private func didSaveChanges() {
        print("didSaveChanges")
    }
}











