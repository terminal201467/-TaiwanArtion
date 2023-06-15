//
//  RegisterViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

class RegisterViewController: UIViewController {

    private let registerView = RegisterView()
    
    //MARK: -LifeCycle
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    //MARK: - Methods
    private func setNavigationBar() {
        navigationController?.navigationItem.title = "會員註冊"
        let backButton = UIBarButtonItem(image: .init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setCollectionView() {
        
    }
    
    private func setTableView() {
        
    }

}
