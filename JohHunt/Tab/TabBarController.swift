import UIKit
import DesignKit
import JHAccount
import JHAuth
import Swinject

class TabBarController: UITabBarController {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = .accent
    }
    
    private func setupViewControllers() {
        let home = UIViewController()
        home.tabBarItem = Tab.home.tabBarItem
        
        let jobs = UIViewController()
        jobs.tabBarItem = Tab.jobs.tabBarItem
        
        let messages = UIViewController()
        messages.tabBarItem = Tab.messages.tabBarItem
        
        let account = setupAccount()
        
        viewControllers = [
            home,
            jobs,
            messages,
            account
        ]
        
        selectedViewController = account
    }
    
    private func setupAccount() -> UIViewController {
        let viewModel = AccountViewModel(container: container)
        let account = AccountViewController()
        account.viewModel = viewModel
        
        let accountNav = UINavigationController(rootViewController: account)
        account.tabBarItem = Tab.account.tabBarItem
        account.title = Tab.account.tabBarItem.title
        
        return accountNav
    }
}









