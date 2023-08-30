//
//  NewsSearchingResultView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/28.
//

import UIKit

class NewsSearchingResultView: UIView {
    
    var isSearchingMode: Bool = false {
        didSet {
            setContentView()
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
    
    private let newsNotFoundView = NothingSearchedView(frame: .zero, type: .newsNothingSearch)
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 20)
        return tableView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.applyShadow(color: .black, opacity: 0.1, offset: CGSize(width: 0.5, height: 0.5), radius: 1)
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 20)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContainerView()
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerView() {
        backgroundColor = .caramelColor
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
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
    
    private func setContentView() {
        containerView.removeAllSubviews(from: containerView)
        isSearchingMode ? setTableViewAutoLayout() : setNotFoundAutoLayout()
    }
}
