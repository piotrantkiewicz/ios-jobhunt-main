import UIKit
import DesignKit
import JHAccount

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
        
        let account = AccountViewController()
        let accountNav = UINavigationController(rootViewController: account)
        account.tabBarItem = Tab.account.tabBarItem
        account.title = Tab.account.tabBarItem.title
        
        viewControllers = [
            home,
            jobs,
            messages,
            accountNav
        ]
        
        selectedViewController = accountNav
    }
}
