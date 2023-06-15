//
//  CalenderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit
import SnapKit

class CalendarView: UIView {
    
    enum CalendarRow: Int, CaseIterable {
        case year = 0, month, week, date
    }
    
    private let logicViewModel = CalendarLogic.shared
    
    var month: ((Int) -> Void)?
    
    var date: ((Int) -> Void)?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.reuseIdentifier)
        tableView.register(CalendarDateTableViewCell.self, forCellReuseIdentifier: CalendarDateTableViewCell.reuseIdentifier)
        tableView.register(CalendarMonthTableViewCell.self, forCellReuseIdentifier: CalendarMonthTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
        autoLayout()
    }
    
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

extension CalendarView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CalendarRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CalendarRow(rawValue: indexPath.row) {
        case .year:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
            let yearHeader = TitleHeaderView()
            yearHeader.configureYear(with: "\(logicViewModel.getCurrentYear())")
            cell.contentView.addSubview(yearHeader)
            yearHeader.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
            return cell
        case .month:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalendarMonthTableViewCell.reuseIdentifier, for: indexPath) as! CalendarMonthTableViewCell
            return cell
        case .week:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.reuseIdentifier, for: indexPath) as! WeekTableViewCell
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalendarDateTableViewCell.reuseIdentifier, for: indexPath) as! CalendarDateTableViewCell
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch CalendarRow(rawValue: indexPath.row) {
        case .year: return 50
        case .month: return 50
        case .week: return 50
        case .date: return 300
        case .none: return 0
        }
    }
}

