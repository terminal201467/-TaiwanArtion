//
//  ResetSucceedViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/17.
//

import UIKit

class ResetSucceedViewController: UIViewController {

    private let resetSucceedView = ResetSucceedView()
    
    private let countDownTimer = CountdownTimer(timeInterval: 3)
    
    //MARK: -LifeCycle
    override func loadView() {
        super.loadView()
        view = resetSucceedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCountDown()
    }
    
    private func setNavigationBar() {
        title = "重設密碼成功"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.brownTitleColor, // 标题颜色为红色
            .font: UIFont.systemFont(ofSize: 18, weight: .bold) // 标题字体为粗体
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    private func setCountDown() {
        countDownTimer.start()
        countDownTimer.onCompleted = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
