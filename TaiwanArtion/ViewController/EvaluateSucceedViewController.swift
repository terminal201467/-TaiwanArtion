//
//  EvaluateSucceedViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class EvaluateSucceedViewController: UIViewController {

    private let completeSucceedView = CompleteSucceedView()
    
    private let timer = CountdownTimer(timeInterval: 3)
    
    override func loadView() {
        super.loadView()
        view = completeSucceedView
        view.backgroundColor = .caramelColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimeBackToExhibitionCardPage()
        completeSucceedView.configure(title: "評價成功", subTitle: "感謝您的分享，造福了其他早找展覽的使用者！")
        
    }
    
    private func setTimeBackToExhibitionCardPage() {
        timer.start()
        timer.onCompleted = {
            //跳回前兩層的ViewController(可能可以另外寫一個Extension)
            if let navigationController = self.navigationController {
                let viewControllers = navigationController.viewControllers
                if viewControllers.count >= 2 {
                    let targetViewController = viewControllers[viewControllers.count - 3]
                    navigationController.popToViewController(targetViewController, animated: true)
                }
            }

        }
    }
}
