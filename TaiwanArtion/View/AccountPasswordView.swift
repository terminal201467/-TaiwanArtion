//
//  AccountPasswordView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit

enum AccountPasswordCell: Int, CaseIterable {
    case account = 0, password, passwordHint, strengthHint, nextButton
    var sectionHeaderText: String {
        switch self {
        case .account: return "帳號"
        case .password: return "密碼"
        case .passwordHint: return "密碼提示"
        case .strengthHint: return "密碼強度"
        case .nextButton: return "下一步"
        }
    }
}

enum AccountPasswordVerifyStep: Int, CaseIterable {
    case stepOne = 0, stepTwo
}

class AccountPasswordView: UIView {

    var toNextStep: (() -> Void)?
    
    private let contentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(PhoneNumberInputTableViewCell.self, forCellReuseIdentifier: PhoneNumberInputTableViewCell.reuseIdentifier)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(SendVerifyTextFieldTableViewCell.self, forCellReuseIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
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
        contentTableView.dataSource = self
        contentTableView.delegate = self
    }
    
    private func autoLayout() {
        addSubview(contentTableView)
        contentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AccountPasswordView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TitleHeaderView()
        switch AccountPasswordCell(rawValue: section) {
        case .account: view.configureTitle(with: AccountPasswordCell.account.sectionHeaderText)
        case .password: view.configureTitle(with: AccountPasswordCell.password.sectionHeaderText)
        case .passwordHint: break
        case .strengthHint: break
        case .nextButton: break
        case .none: break
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch AccountPasswordCell(rawValue: section) {
        case .account:
        case .password:
        case .passwordHint:
        case .strengthHint:
        case .nextButton:
        case .none:
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
