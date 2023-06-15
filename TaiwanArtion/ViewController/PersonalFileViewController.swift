//
//  PersonalFileViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit

class PersonalFileViewController: UIViewController {

    private let welcomeRegisterView = WelcomeRegisterView()
    
    private let userManager = UserManager.shared
    
    override func loadView() {
        super.loadView()
        manageUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    private func manageUser() {
        
        if userManager.getIsLoggedIn() {
            //已經都登入過
            
        } else {
            //如果未註冊
            view = welcomeRegisterView
        }
        //這邊要有UserDefault的設定
        
        //如果已經註冊，也已經登入
        
        //如果已經註冊過，未登入
    
        
    }

}
