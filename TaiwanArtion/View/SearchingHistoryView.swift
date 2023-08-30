//
//  SearchingHistoryView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import UIKit

class SearchingHistoryView: UIView {
    
    var didSelectedHistory: ((Int) -> Void)?
    
    var historys: [String] = [] {
        didSet {
            setViewToContainer()
            filterSearchingtableView.reloadData()
        }
    }
    
    var type: ExhibitionNothingSearchType
    
    init(frame: CGRect, historys: [String], type: ExhibitionNothingSearchType) {
        self.historys = historys
        self.type = type
        super.init(frame: frame)
        setTableView()
        autoLayout()
        setViewToContainer()
    }
    
    private let containerView: UIView = {
       let view = UIView()
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return view
    }()
    
    lazy var exhibitionSearchedNothingView = NothingSearchedView(frame: .zero, type: self.type)
    
    private let filterSearchingtableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        filterSearchingtableView.delegate = self
        filterSearchingtableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setViewToContainer() {
        containerView.removeAllSubviews(from: containerView)
        if historys.isEmpty {
            containerView.addSubview(exhibitionSearchedNothingView)
            exhibitionSearchedNothingView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            containerView.addSubview(filterSearchingtableView)
            filterSearchingtableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
extension SearchingHistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let titleHeader = TitleHeaderView()
        containerView.addSubview(titleHeader)
        titleHeader.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleHeader.configureTitle(with: "搜尋紀錄")
        titleHeader.configureButton(with: "清除紀錄")
        titleHeader.button.setTitleColor(.brownColor, for: .normal)
        titleHeader.buttonAction = {
            self.historys.removeAll()
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reuseIdentifier, for: indexPath) as! SearchHistoryTableViewCell
        cell.configure(history: historys[indexPath.row])
        cell.deleteHistory = {
            self.historys.remove(at: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedHistory?(indexPath.row)
    }
}
