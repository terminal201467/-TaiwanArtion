//
//  RegisterSucceedViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/20.
//

import UIKit

class RegisterSucceedViewController: UIViewController {

    private let completeSucceedView = CompleteSucceedView()
    
    override func loadView() {
        super.loadView()
        view = completeSucceedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
        setCompleteSucceedView()
        
    }
    
    private func setCompleteSucceedView() {
        completeSucceedView.configure(title: "註冊成功", subTitle: "恭喜您,已完成註冊！")
    }

    private func setButtonAction() {
        completeSucceedView.buttonStack.isHidden = false
        completeSucceedView.topButtonAction = {
            //到填寫個人頁面ViewController
        }
        
        completeSucceedView.bottomButtonAction = {
            //到會員登入頁面
        }
        
    }
}
