//
//  NearViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit

class NearViewController: UIViewController {

    private let nearView = NearView()
    
    private let viewModel = NearViewModel.shared
    
    private let resultViewController = UINavigationController(rootViewController: NearSearchResultViewController())
    
    private lazy var searchViewController: UISearchController = {
       let searchViewController = UISearchController(searchResultsController: resultViewController)
        searchViewController.searchBar.searchTextField.roundCorners(cornerRadius: 20)
        searchViewController.showsSearchResultsController = true
        return searchViewController
    }()
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = nearView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.titleView = searchViewController.searchBar
    }
}

extension NearViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("searchTextField:\(textField.text)")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("textField:\(textField.text)")
    }
}
