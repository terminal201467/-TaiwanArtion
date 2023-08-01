//
//  SearchingHistoryView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import UIKit

class SearchingHistoryView: UIView {
    
    var historys: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(frame: CGRect, historys: [String]) {
        self.historys = historys
        super.init(frame: frame)
        setTableView()
        autoLayout()
    }
    
    private let tableView: UITableView = {
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
}
