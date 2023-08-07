//
//  CollectViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

protocol ResultControllerDelegate: AnyObject {
    func resultControllerDidCancelSearch()
}

class CollectViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private let collectView = CollectView()
    
    private let viewModel = CollectViewModel()
    
    private let resultController = ResultViewController()
    
    private lazy var searchViewController: UISearchController = {
       let searchViewController = UISearchController(searchResultsController: resultController)
        searchViewController.searchBar.searchTextField.roundCorners(cornerRadius: 20)
        searchViewController.searchBar.searchTextField.backgroundColor = .white
        searchViewController.searchBar.searchBarStyle = .default
        searchViewController.searchBar.showsCancelButton = false
        searchViewController.showsSearchResultsController = true
        searchViewController.searchBar.searchTextField.placeholder = "搜尋已收藏的展覽"
        return searchViewController
    }()
    
    override func loadView() {
        super.loadView()
        view = collectView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setMenuSelected()
        setNavigationBar()
    }
    
    //MARK: -Methods
    private func setNavigationBar() {
        navigationItem.searchController = searchViewController
    }
    
    @objc func back() {
        
    }
    
    private func setSearchResult() {
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.searchTextField.delegate = self
    }
    
    private func setCollectionView() {
        collectView.contents.delegate = self
        collectView.contents.dataSource = self
    }
    
    private func setMenuSelected() {
        collectView.menu.selectedMenuItem = { selectedMenuItem in
            print("selectedMenuItem:\(selectedMenuItem)")
            self.viewModel.input.currentCollectMenu.accept(selectedMenuItem)
        }
        
        viewModel.output.currentSelectedCollectMenuIndex
            .subscribe(onNext: { menuIndex in
                self.collectView.menu.currentMenu = menuIndex
            })
            .disposed(by: disposeBag)
        
        collectView.selectedTimeMenu = { menuIndex in
            print("menuIndex:\(menuIndex)")
            self.viewModel.input.currentTimeMenu.accept(menuIndex)
        }
        
        viewModel.output.currentSelectedTimeMenu
            .subscribe(onNext: { menuIndex in
                print("menuIndex:\(menuIndex)")
                self.collectView.currentTimeMenuSelected = menuIndex
            })
            .disposed(by: disposeBag)
    }
}

extension CollectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.currentExhibitionContent.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllExhibitionCollectionViewCell.reuseIdentifier, for: indexPath) as! AllExhibitionCollectionViewCell
        print("viewModel.output.currentExhibitionContent.value:\(viewModel.output.currentExhibitionContent.value)")
        cell.configure(with: viewModel.output.currentExhibitionContent.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ExhibitionCardViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        //這邊應該要提供給展覽資料
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.view.frame.width - (16 * 2) - 24) / 2
        let cellHeight = 233.0
        return .init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension CollectViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension CollectViewController: ResultControllerDelegate {
    func resultControllerDidCancelSearch() {
        
    }
}

extension CollectViewController: UISearchTextFieldDelegate {
    
    
}
