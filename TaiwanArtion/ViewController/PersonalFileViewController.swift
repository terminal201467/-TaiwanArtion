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
        view = welcomeRegisterView
        manageUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActions()
        // Do any additional setup after loading the view.
    }
    

    private func manageUser() {
//
        //這邊要有UserDefault的設定
        
        //如果已經註冊，也已經登入
        
        //如果已經註冊過，未登入
    }
    
    private func setActions() {
        welcomeRegisterView.registerAction = {
            let viewController = RegisterViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        welcomeRegisterView.loginAction = {
            let viewController = LoginViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        welcomeRegisterView.socialKitRegister = { socialKitKind in
            print(socialKitKind)
            switch socialKitKind {
            case "facebook": self.userManager.input.facebookLoginSubject.onNext(())
            case "google": self.userManager.input.googleLoginSubject.onNext(())
            case "line": print("not Define")
            default: print("default")
            }
        }
    }

}
