import UIKit
import SnapKit
import JHCore

public final class AccountViewController: UIViewController {
    
    enum Row: Int, CaseIterable {
        case header
        case notification
        case theme
        case helpCenter
        case rateOurApp
        case termOfService
        case logout
    }
    
    private weak var tableView: UITableView!
    
    public var viewModel: AccountViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        
        viewModel.didUpdateHeader = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchUserProfile()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AccountHeaderCell.self, forCellReuseIdentifier: AccountHeaderCell.identifier)
        tableView.register(AccountOptionCell.self, forCellReuseIdentifier: AccountOptionCell.identifier)
        tableView.register(AccountLogoutCell.self, forCellReuseIdentifier: AccountLogoutCell.identifier)
    }
}

extension AccountViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationTitle()
        setupTableView()
    }
    
    private func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.title3
        ]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        self.tableView = tableView
    }
}

extension AccountViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Row.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch row {
            
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountHeaderCell.identifier, for: indexPath) as? AccountHeaderCell
            else { return UITableViewCell() }
            
            cell.configure(with: viewModel.header)
            
            return cell
        case .notification:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.identifier, for: indexPath) as? AccountOptionCell
            else { return UITableViewCell() }
            
            cell.configure(with: .notification)
            
            return cell
        case .theme:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.identifier, for: indexPath) as? AccountOptionCell
            else { return UITableViewCell() }
            
            cell.configure(with: .theme)
            
            return cell
        case .helpCenter:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.identifier, for: indexPath) as? AccountOptionCell
            else { return UITableViewCell() }
            
            cell.configure(with: .helpCenter)
            
            return cell
        case .rateOurApp:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.identifier, for: indexPath) as? AccountOptionCell
            else { return UITableViewCell() }
            
            cell.configure(with: .rateOurApp)
            
            return cell
        case .termOfService:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.identifier, for: indexPath) as? AccountOptionCell
            else { return UITableViewCell() }
            
            cell.configure(with: .termOfService)
            
            return cell
        case .logout:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountLogoutCell.identifier, for: indexPath) as? AccountLogoutCell
            else { return UITableViewCell() }
            
            cell.configure(with: .logout)
            
            return cell
        }
    }
}

extension AccountViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = Row(rawValue: indexPath.row) else { return }
        
        switch row {
        case .header:
            presentProfileEdit()
        case .logout:
            print("logout")
        default:
            break
        }
    }
    
    private func presentProfileEdit() {
        let viewModel = ProfileEditViewModel(userRepository: viewModel.userRepository)
        let controller = ProfileEditViewController()
        controller.hidesBottomBarWhenPushed = true
        controller.viewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Row(rawValue: indexPath.row)! {
        case .header:
            return 88
        default:
            return 56
        }
    }
}










