//
//  RegisterSucceedViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/20.
//

import UIKit

class RegisterSucceedViewController: UIViewController {

    private let completeSucceedView = CompleteSucceedView()
    
    var popViewControllerAction: (() -> Void)?
    
    var pushToControllerAction: (() -> Void)?
    
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
        completeSucceedView.configureButtons(topButtonName: "開始填寫個人檔案", bottomButtonName: "略過")
        completeSucceedView.buttonStack.isHidden = false
        completeSucceedView.topButtonAction = {
            self.dismiss(animated: true)
            self.pushToControllerAction?()
        }
        
        completeSucceedView.bottomButtonAction = {
            self.dismiss(animated: true)
            self.popViewControllerAction?()
        }
        
    }
}
