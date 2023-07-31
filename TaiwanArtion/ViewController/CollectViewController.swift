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

enum CollectContent: Int, CaseIterable {
    case contentMenu = 0, centents
}

enum ContentMenu: Int, CaseIterable {
    case allExhibition = 0, todayStart, tomorrowStart, weekStart
    var text: String {
        switch self {
        case .allExhibition: return "全部"
        case .todayStart: return "今天開始"
        case .tomorrowStart: return "明天開始"
        case .weekStart: return "本週開始"
        }
    }
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
        collectView.collectionView.delegate = self
        collectView.collectionView.dataSource = self
    }
    
    private func setMenuSelected() {
        collectView.menu.selectedMenuItem = { selectedMenuItem in
//            self.viewModel.input.currentCollectMenu.accept(selectedMenuItem)
        }
    }
}

extension CollectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CollectContent.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch CollectContent(rawValue: section) {
        case .contentMenu: return ContentMenu.allCases.count
        case .centents: return viewModel.output.currentExhibitionContent.value.count
        case .none: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CollectContent(rawValue: indexPath.section) {
        case .contentMenu:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
            let isSelected = self.viewModel.currentContentMenu == indexPath.row
            cell.configure(with: ContentMenu.allCases[indexPath.row].text, selected: isSelected)
            return cell
        case .centents:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllExhibitionCollectionViewCell.reuseIdentifier, for: indexPath) as! AllExhibitionCollectionViewCell
            cell.configure(with: viewModel.output.currentExhibitionContent.value[indexPath.row])
            return cell
        case .none: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch CollectContent(rawValue: indexPath.section) {
        case .contentMenu:
            viewModel.currentContentMenu = indexPath.row
            collectionView.reloadData()
        case .centents:
            let viewController = ExhibitionCardViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            //這邊應該要提供給展覽資料
        case .none: print("none")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = self.view.frame.width
        let collectionViewHeight = collectionView.frame.height
        switch CollectContent(rawValue: indexPath.section) {
        case .contentMenu: return .init(width: collectionViewWidth / 5, height: 34.0)
        case .centents:
            let cellHeight = collectionViewHeight - (34 + 48)
            return .init(width: collectionViewWidth - 24 * 2 / 2, height: cellHeight)
        case .none: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch CollectContent(rawValue: section) {
        case .contentMenu: return .init(top: 24, left: 16, bottom: 24, right: 16)
        case .centents: return .init(top: 24, left: 16, bottom: 24, right: 16)
        case .none: return .zero
        }
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
