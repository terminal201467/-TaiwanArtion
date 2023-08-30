//
//  NewsSearchingView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/28.
//

import UIKit

class NewsSearchingView: UIView {
    
    var isSearchingMode: Bool = false {
        didSet {
            self.setContentsAutoLayout()
        }
    }
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.placeholder = "搜尋新聞"
        searchBar.searchTextField.roundCorners(cornerRadius: 20)
        searchBar.searchTextField.tintColor = .grayTextColor
        return searchBar
    }()

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MonthsHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: MonthsHorizontalCollectionViewCell.reuseIdentifier)
        collectionView.register(FilterNewsHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: FilterNewsHorizontalCollectionViewCell.reuseIdentifier)
        collectionView.register(HabbyCollectionViewCell.self, forCellWithReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(TitleCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableHeaderView.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 20)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 20)
        return tableView
    }()
    
    private let newsNotFoundView = NothingSearchedView(frame: .zero, type: .newsNothingSearch)
    
    //可能這邊還要有一個搜尋到資料後的內容的CollectionView
    
    private let containerView: UIView = {
        let view = UIView()
        view.applyShadow(color: .black, opacity: 0.1, offset: CGSize(width: 0.5, height: 0.5), radius: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContainerAutoLayout()
        setContentsAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewAutoLayout() {
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setTableViewAutoLayout() {
        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNotFoundAutoLayout() {
        containerView.addSubview(newsNotFoundView)
        newsNotFoundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setContainerAutoLayout() {
        backgroundColor = .caramelColor
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setContentsAutoLayout() {
        containerView.removeAllSubviews(from: containerView)
        isSearchingMode ? setTableViewAutoLayout() : setCollectionViewAutoLayout()
    }
}
