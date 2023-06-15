//
//  RootViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit

class RootViewController: UITabBarController {
    
    //MARK: - ViewControllers
    private let homeViewController = UINavigationController(rootViewController: HomeViewController())
    
    private let nearViewController = NearViewController()
    
    private let collectionViewController = CollectionViewController()
    
    private let calendarViewController = CalendarViewController()
    
    private let personFileViewController = UINavigationController(rootViewController: PersonalFileViewController())
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTabBar()
    }
    
    //MARK: - Methods
    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func setTabBar() {
        homeViewController.tabBarItem = UITabBarItem(title: "首頁",
                                                     image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal),
                                                     selectedImage: UIImage(named: "homeSelected")?.withRenderingMode(.alwaysOriginal))
        homeViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brownTitleColor], for: .selected)
        nearViewController.tabBarItem = UITabBarItem(title: "附近展覽",
                                                     image: UIImage(named: "near")?.withRenderingMode(.alwaysOriginal),
                                                     selectedImage: UIImage(named: "nearSelected")?.withRenderingMode(.alwaysOriginal))
        nearViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brownTitleColor], for: .selected)
        collectionViewController.tabBarItem = UITabBarItem(title: "收藏展覽",
                                                           image: UIImage(named: "collect")?.withRenderingMode(.alwaysOriginal),
                                                           selectedImage: UIImage(named: "collectSelect")?.withRenderingMode(.alwaysOriginal))
        collectionViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brownTitleColor], for: .selected)
        calendarViewController.tabBarItem = UITabBarItem(title: "展覽月曆",
                                                         image: UIImage(named: "calendar")?.withRenderingMode(.alwaysOriginal),
                                                         selectedImage: UIImage(named: "calendarSelected")?.withRenderingMode(.alwaysOriginal))
        calendarViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brownTitleColor], for: .selected)
        personFileViewController.tabBarItem = UITabBarItem(title: "個人檔案",
                                                           image: UIImage(named: "personal")?.withRenderingMode(.alwaysOriginal),
                                                           selectedImage: UIImage(named: "personalSelected")?.withRenderingMode(.alwaysOriginal))
        personFileViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.brownTitleColor], for: .selected)
        viewControllers = [homeViewController, nearViewController, collectionViewController, calendarViewController, personFileViewController]
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 12)
    }
}

