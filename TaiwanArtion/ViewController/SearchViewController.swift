//
//  SearchViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel = SearchViewModel.shared
    
    private let searchView = SearchView()
    
    private var isSearchModeViewOn: Bool = false {
        didSet {
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.filterTableView.reloadData()
        }
    }
    
    var currentSelectedItem: Int? {
        didSet {
            self.searchView.filterTableView.reloadData()
        }
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableView()
        setCollectionView()
        setSearchindModeChanged()
        searchView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        self.viewModel.changedModeWith(isSearching: isSearchModeViewOn)
        setCurrentItemChanged()
    }
    
    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func setTableView() {
        searchView.filterTableView.delegate = self
        searchView.filterTableView.dataSource = self
    }
    
    private func setCollectionView() {
        searchView.filterContentCollectionView.dataSource = self
        searchView.filterContentCollectionView.delegate = self
    }
    
    private func setSearchindModeChanged() {
        searchView.isBeginSearchMode = { changed in
            self.viewModel.changedModeWith(isSearching: changed)
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.filterTableView.reloadData()
        }
    }
    
    private func setCurrentItemChanged() {
        self.currentSelectedItem = viewModel.getCurrentItem()
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewNumberOfRowInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellInfo = viewModel.collectionViewCellForRowAt(indexPath: indexPath)
        if isSearchModeViewOn {
            switch AlreadyFilter(rawValue: indexPath.row) {
            case .result:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .news:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .nearest:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .filterIcon:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
                cell.configure(iconText: cellInfo.title)
                return cell
            case .none: print("none")
                return UICollectionViewCell()
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
            cell.configure(title: FilterType.allCases[indexPath.row].text, isSelected: cellInfo.isSelected)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 15 * 6) / 5
        let cellHeight = 48.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionViewDidSelectedRowAt(indexPath: indexPath)
        searchView.filterContentCollectionView.reloadData()
        searchView.filterTableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchModeViewOn {
            return viewModel.searchModeTableViewNumberOfRowInSection(section: section)
        } else {
            return viewModel.unSearchModeTableViewNumberOfRowInSection(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isSearchModeViewOn {
            if viewModel.getCurrentItem() == nil {
                let view = TitleHeaderView()
                view.configureTitle(with: "熱門搜尋")
                view.checkMoreButton.isHidden = true
                return view
            } else {
                switch FilterType(rawValue: viewModel.getCurrentItem()!) {
                case .city:
                    let view = TitleHeaderView()
                    view.configureTitle(with: Area.allCases[section].text)
                    view.checkMoreButton.isHidden = false
                    return view
                case .place:
                    let view = TitleHeaderView()
                    view.configureTitle(with: "展覽館")
                    view.checkMoreButton.isHidden = false
                    view.checkMoreButton.setTitle("全選", for: .normal)
                    return view
                case .date:
                    switch TimeSection(rawValue: section) {
                    case .dateKind:
                        let view = TitleHeaderView()
                        view.configureTitle(with: "時間")
                        view.checkMoreButton.isHidden = false
                        view.checkMoreButton.setTitle("全選", for: .normal)
                        return view
                    case .calendar:
                        let view = TitleHeaderView()
                        view.configureTitle(with: "日期")
                        view.checkMoreButton.isHidden = false
                        view.checkMoreButton.setTitle("全選", for: .normal)
                        return view
                    case .none:
                        return UICollectionViewCell()
                    }
                case .price:
                    let view = TitleHeaderView()
                    view.configureTitle(with: "票價")
                    view.checkMoreButton.isHidden = false
                    view.checkMoreButton.setTitle("全選", for: .normal)
                    return view
                case .none:
                    return UICollectionViewCell()
                }
            }
        } else {
            if viewModel.getCurrentItem() == nil {
                let view = TitleHeaderView()
                view.configureTitle(with: "熱門搜尋")
                view.checkMoreButton.isHidden = true
                return view
            } else {
                let view = TitleHeaderView()
                view.configureTitle(with: "找到\(0)筆展覽")
                return view
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //搜尋狀態
        if isSearchModeViewOn {
            if let currentItem = viewModel.getCurrentItem() {
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as! SearchResultTableViewCell
                viewModel.searchModeTableViewCellForRowAt(indexPath: indexPath).map { info in
                    cell.configure(image: info.image,
                                   tag: info.tag,
                                   title: info.title,
                                   date: info.dateString,
                                   city: info.city,
                                   starCount: info.evaluation?.allCommentStar ?? 1,
                                   commentCount: info.evaluation?.allCommentCount ?? 1)
                }
                return cell
            }
        } else {
        //非搜尋狀態
            let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
            if let currentItem = viewModel.getCurrentItem() {
                switch FilterType(rawValue: viewModel.getCurrentItem()!) {
                case .city:
                    switch Area(rawValue: indexPath.section) {
                    case .north:
                        let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                        cell.configure(itemTitle: unSearchModel)
                        return cell
                    case .middle:
                        let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                        cell.configure(itemTitle: unSearchModel)
                        return cell
                    case .south:
                        let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                        cell.configure(itemTitle: unSearchModel)
                        return cell
                    case .east:
                        let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                        cell.configure(itemTitle: unSearchModel)
                        return cell
                    case .island:
                        let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                        cell.configure(itemTitle: unSearchModel)
                        return cell
                    case .none:
                        return UITableViewCell()
                    }
                case .place:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
                    cell.configure(itemTitle: Place.allCases.map{$0.title})
                    return cell
                case .date:
//                    let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
                    cell.configure(itemTitle: DateKind.allCases.map{$0.text})
                    return cell
                case .price:
                    cell.configure(itemTitle: Price.allCases.map{$0.text})
                    return cell
                case .none: return UITableViewCell()
                }
                
                if FilterType(rawValue: viewModel.getCurrentItem()!)  == .date {
                    switch TimeSection(rawValue: indexPath.section) {
                    case .dateKind:
                        let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
                        let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                        cell.configure(itemTitle: unSearchModel)
                        return cell
                    case .calendar:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
                        let calendar = CalendarView()
                        cell.contentView.addSubview(calendar)
                        return cell
                    case .none: return UITableViewCell()
                    }
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
                    let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                    cell.configure(itemTitle: unSearchModel)
                    return cell
                }
            } else {
                let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
                let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
                print("unSearchModel：\(unSearchModel)")
                cell.configure(itemTitle: unSearchModel)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
