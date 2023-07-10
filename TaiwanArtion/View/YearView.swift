//
//  YearView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/10.
//

import UIKit

class YearView: UIView {
    
    var selectedYear: ((String) -> Void)?
    
    private var currentYear: IndexPath?
    
    private let dateInterface = DateInterface()
    
    private var years: [String] = []

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(YearCellTableViewCell.self, forCellReuseIdentifier: YearCellTableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTable()
        autoLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configure() {
        years = dateInterface.generateYearStrings()
    }
}

extension YearView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        years.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YearCellTableViewCell.reuseIdentifier, for: indexPath) as! YearCellTableViewCell
        let cellContentYear = years[indexPath.row]
        if currentYear != nil {
            let isSelected = cellContentYear == years[currentYear!.row]
            cell.configure(year: cellContentYear, isSelected: isSelected)
        } else {
            cell.configure(year: cellContentYear, isSelected: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedYear?(years[indexPath.row])
        currentYear = indexPath
        tableView.reloadData()
    }
}
