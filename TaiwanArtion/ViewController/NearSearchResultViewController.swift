//
//  NearSearchResultViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/17.
//

import UIKit
import RxSwift

class NearSearchResultViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = NearViewModel.shared
    
    private let nearSearchReaultView = NearSearchResultView()
    
    //MARK: -LifeCycle
    override func loadView() {
        super.loadView()
        view = nearSearchReaultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        viewModel.output.outputSearchHistory
            .subscribe(onNext: { historyInfos in
                self.nearSearchReaultView.configure(historys: historyInfos)
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }

    private func setNavigationBar() {
        let leftButton = UIBarButtonItem(image: .init(named: "leftArrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem  = leftButton
        navigationItem.titleView = nearSearchReaultView.searchBar
    }
    
    @objc private func back() {
        dismiss(animated: true)
    }
}
