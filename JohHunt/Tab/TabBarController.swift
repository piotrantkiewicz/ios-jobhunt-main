import UIKit
import DesignKit
import JHAccount
import JHAuth

class TabBarController: UITabBarController {
    
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
        
        let authService = AuthServiceLive()
        let userRepository = UserProfileRepositoryLive(authService: authService)
        let viewModel = AccountViewModel(userRepository: userRepository)
        let account = AccountViewController()
        account.viewModel = viewModel
        
        let accountNav = UINavigationController(rootViewController: account)
        account.tabBarItem = Tab.account.tabBarItem
        account.title = Tab.account.tabBarItem.title
        
        return accountNav
    }
}









