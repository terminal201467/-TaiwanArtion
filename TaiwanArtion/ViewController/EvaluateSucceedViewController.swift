//
//  EvaluateSucceedViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class EvaluateSucceedViewController: UIViewController {

    private let evaluateSucceedView = EvaluateSucceedView()
    
    private let timer = CountdownTimer(timeInterval: 3)
    
    override func loadView() {
        super.loadView()
        view = evaluateSucceedView
        view.backgroundColor = .caramelColor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimeBackToExhibitionCardPage()
        // Do any additional setup after loading the view.
    }
    
    private func setTimeBackToExhibitionCardPage() {
        timer.start()
        timer.onCompleted = {
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
