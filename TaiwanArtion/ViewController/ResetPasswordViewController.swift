//
//  ResetPasswordViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    private let resetPasswordView = ResetPasswordView()
    
    private var currentStep: ResetStep = .stepOne {
        didSet {
            setStepView()
        }
    }
    
    private var stepOneView: ResetView?
    
    private var stepTwoView: NewPasswordView?
    
    override func loadView() {
        super.loadView()
        view = resetPasswordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setStepView()
    }
    
    private func setNavigationBar() {
        title = "重設密碼"
        let leftBarItem = UIBarButtonItem(image: .init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

    private func setStepView() {
        switch currentStep {
        case .stepOne:
            let resetView = ResetView()
            stepOneView = resetView
            resetPasswordView.containerView.addSubview(stepOneView!)
            stepOneView?.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            resetView.nextStep = { self.currentStep = .stepTwo}
        case .stepTwo:
            let newsPasswordView = NewPasswordView()
            stepTwoView = newsPasswordView
            resetPasswordView.containerView.addSubview(stepTwoView!)
            stepTwoView?.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            newsPasswordView.nextAction = {
                //推到重設密碼成功頁面
            }
        }
    }
}
