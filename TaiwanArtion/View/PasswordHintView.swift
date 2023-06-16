//
//  PasswordHintView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit

enum PasswordHintCell: Int, CaseIterable {
    case passwordHint = 0, uppercaseHint, lowercaseHint, atLeastHint, onlyWordsSomething
    var text: String {
        switch self {
        case .passwordHint: return "密碼提示"
        case .uppercaseHint: return "至少一個大寫字母"
        case .lowercaseHint: return "至少一個小寫字母"
        case .atLeastHint: return "8-16位英.數字"
        case .onlyWordsSomething: return "僅能使用英文.數字或特殊標點符號"
        }
    }
}

class PasswordHintView: UIView {
    
    //檢查邏輯的ViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PasswordHintTableViewCell.self, forCellReuseIdentifier: PasswordHintTableViewCell.reuseIdentifier)
        tableView.allowsSelection = false
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

extension PasswordHintView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PasswordHintCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PasswordHintTableViewCell.reuseIdentifier, for: indexPath) as! PasswordHintTableViewCell
        switch PasswordHintCell(rawValue: indexPath.row) {
        case .passwordHint: cell.configureHintTitle(imageName: "infomation", listText: PasswordHintCell.passwordHint.text)
        case .uppercaseHint: cell.configureList(listText: PasswordHintCell.uppercaseHint.text, isThroughTest: false)
        case .lowercaseHint: cell.configureList(listText: PasswordHintCell.lowercaseHint.text, isThroughTest: false)
        case .atLeastHint: cell.configureList(listText: PasswordHintCell.atLeastHint.text, isThroughTest: false)
        case .onlyWordsSomething: cell.configureList(listText: PasswordHintCell.onlyWordsSomething.text, isThroughTest: false)
        case .none: break
        }
        return cell
    }
    
}
