//
//  ResultViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import UIKit

enum Mode: Int {
    case searchingMode = 0, nothingMode, filterMode
}

class ResultViewController: UIViewController {
    
    weak var delegate: ResultControllerDelegate?
    
    private let resultView = ResultView()
    
    private let viewModel = ResultViewModel()

    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMenu()
    }
    
    private func setMenu() {
        resultView.menu.selectedMenuItem = { selectItem in
            //接收現在的page
        }
    }
    
    private func setContainer() {
//        resultView.cont
    }
    
    
    @objc func backButtonTapped() {
        // 在這裡執行返回操作，例如返回上一個畫面
        // 或者退出搜索模式（如果你想保留搜索結果，可以不退出搜索模式）
        delegate?.resultControllerDidCancelSearch()
    }

}
