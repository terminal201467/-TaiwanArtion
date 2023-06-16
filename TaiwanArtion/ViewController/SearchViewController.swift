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
            self.viewModel.restartTheCurrentItem()
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.filterTableView.reloadData()
        }
    }
    
    var currentSelectedItem: Int? {
        didSet {
            print("currentSelectedItem:\(currentSelectedItem)")
            self.hiddenLocation()
            self.searchView.filterTableView.reloadData()
            self.searchView.filterContentCollectionView.reloadData()
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
        viewModel.restartTheCurrentItem()
        searchView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        setCurrentItem()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        isSearchModeViewOn = false
        searchView.filterTableView.endEditing(true)
        searchView.filterContentCollectionView.endEditing(true)
    }
    
    //MARK: - Methods
    private func setNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func hiddenLocation() {
        if isSearchModeViewOn {
            searchView.hiddenThelocationStack(isHidden: true)
        } else {
            if currentSelectedItem == nil {
                searchView.hiddenThelocationStack(isHidden: false)
            } else {
                if let selectedItem = currentSelectedItem {
                    if selectedItem == 0 {
                        searchView.hiddenThelocationStack(isHidden: false)
                    } else {
                        searchView.hiddenThelocationStack(isHidden: true)
                    }
                }
            }
        }
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
        searchView.isBeginSearchMode = { isBegan in
            self.viewModel.changedModeWith(isSearching: isBegan)
            self.isSearchModeViewOn = isBegan
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.filterTableView.reloadData()
        }
        
        searchView.searchValueChanged = { changed in
            print("changed:\(changed)")
            self.viewModel.filterSearchTextFiled(withText: changed)
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.filterTableView.reloadData()
            
        }
        
        searchView.endInputText = { endText in
            print("finalSearch:\(endText)")
            self.viewModel.filterSearchTextFiled(withText: endText)
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.filterTableView.reloadData()
        }
    }
    
    private func setCurrentItem() {
        viewModel.getCurrentItem = { item in
            self.currentSelectedItem = item
        }
    }
    
    private func setContainerView(parentView: UIView, subView: UIView) {
        parentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.edges.equalToSuperview()
        }
    }
}
//MARK: - CollectionView
extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewNumberOfRowInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellInfo = viewModel.collectionViewCellForRowAt(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
        let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
        if isSearchModeViewOn {
            switch AlreadyFilter(rawValue: indexPath.row) {
            case .result:
                cell.setAutoLayoutMode(by: true)
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .news:
                cell.setAutoLayoutMode(by: true)
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .nearest:
                cell.setAutoLayoutMode(by: true)
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .filterIcon:
                buttonCell.configure(iconText: cellInfo.title)
                buttonCell.action = {
                    print("press")
                }
                return buttonCell
            case .none: print("none")
                return UICollectionViewCell()
            }
        } else {
            cell.configure(title: FilterType.allCases[indexPath.row].text, isSelected: cellInfo.isSelected)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0.0
        var cellHeight: CGFloat = 0.0
        if isSearchModeViewOn {
            cellWidth = (view.frame.width - 8 * 5) / 4
            cellHeight = 48.0
        } else {
            cellWidth = (view.frame.width - 8 * 6) / 6
            cellHeight = 48.0
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath:\(indexPath)")
        viewModel.collectionViewDidSelectedRowAt(indexPath: indexPath)
        searchView.filterContentCollectionView.reloadData()
        searchView.filterTableView.reloadData()
    }
    
}

//MARK: - TableView
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
        let containerView = UIView()
        let headerView = TitleHeaderView()
        headerView.buttonAction = {
            self.viewModel.selectedCollectionViewAllCell(bySection: section)
        }
        setContainerView(parentView: containerView, subView: headerView)
        if isSearchModeViewOn {
            if currentSelectedItem == nil {
                headerView.configureTitle(with: "熱門搜尋")
                headerView.button.isHidden = true
            } else {
                headerView.configureTitle(with: "找到\(0)筆展覽")
            }
        } else {
            if currentSelectedItem == nil {
                headerView.configureTitle(with: "熱門搜尋")
                headerView.button.isHidden = true
                return headerView
            } else {
                switch FilterType(rawValue: currentSelectedItem!) {
                case .city:
                    headerView.configureTitle(with: Area.allCases[section].text)
                    headerView.button.isHidden = false
                    headerView.configureButton(with: "全選")
                    if section == 5 {
                        headerView.isHidden = true
                    }
                case .place:
                    headerView.configureTitle(with: "展覽館")
                    headerView.button.isHidden = false
                    headerView.button.setTitle("全選", for: .normal)
                case .date:
                    switch TimeSection(rawValue: section) {
                    case .dateKind:
                        headerView.configureTitle(with: "時間")
                        headerView.button.isHidden = false
                        headerView.button.setTitle("全選", for: .normal)
                    case .calendar:
                        headerView.configureTitle(with: "日期")
                        headerView.button.isHidden = true
                        headerView.button.setTitle("全選", for: .normal)
                    case .correct:
                        headerView.isHidden = true
                    case .none:
                        return UIView()
                    }
                case .price:
                    headerView.configureTitle(with: "票價")
                    headerView.button.isHidden = false
                    headerView.button.setTitle("全選", for: .normal)
                case .none:
                    return UIView()
                }
            }
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //搜尋狀態
        if isSearchModeViewOn {
            if let currentItem = currentSelectedItem {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: UnSearchModeChooseTableViewCell.reuseIdentifier, for: indexPath) as! UnSearchModeChooseTableViewCell
            let calendarCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
            let correctButtonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
            let unSearchModel = viewModel.unSearchModeTableViewCellForRowAt(indexPath: indexPath)
            if currentSelectedItem != nil {
                switch FilterType(rawValue: currentSelectedItem!) {
                case .city:
                    switch Area(rawValue: indexPath.section) {
                    case .north:  cell.configure(itemTitle: unSearchModel)
                    case .middle: cell.configure(itemTitle: unSearchModel)
                    case .south: cell.configure(itemTitle: unSearchModel)
                    case .east: cell.configure(itemTitle: unSearchModel)
                    case .island: cell.configure(itemTitle: unSearchModel)
                    case .correct:
                        correctButtonCell.configure(buttonname: "確定")
                        return correctButtonCell
                    case .none: return cell
                    }
                    return cell
                case .place:
                    cell.configure(itemTitle: Place.allCases.map{$0.title})
                    return cell
                case .date:
                    switch TimeSection(rawValue: indexPath.section) {
                    case .dateKind:
                        cell.configure(itemTitle: DateKind.allCases.map{$0.text})
                        return cell
                    case .calendar:
                        let calendarView = CalendarView()
                        calendarCell.contentView.addSubview(calendarView)
                        calendarView.snp.makeConstraints { make in
                            make.height.equalTo(500)
                            make.top.equalToSuperview()
                            make.leading.equalToSuperview()
                            make.trailing.equalToSuperview()
                            make.bottom.equalToSuperview()
                        }
                        return calendarCell
                    case .correct:
                        correctButtonCell.configure(buttonname: "確定")
                        return correctButtonCell
                    case .none: return cell
                    }
                    return cell
                case .price: cell.configure(itemTitle: Price.allCases.map{$0.text})
                    return cell
                case .none:
                    correctButtonCell.configure(buttonname: "確定")
                    return correctButtonCell
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
