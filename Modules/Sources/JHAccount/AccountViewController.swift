import UIKit
import SnapKit
import JHCore

public final class AccountViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    let viewModel = AccountViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(AccountHeaderCell.self, forCellReuseIdentifier: AccountHeaderCell.identifier)
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
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountHeaderCell.identifier, for: indexPath) as? AccountHeaderCell
        else { return UITableViewCell() }
        
        cell.configure(with: viewModel.header)
        
        return cell
    }
}





