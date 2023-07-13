//
//  NewPasswordView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit

enum NewPasswordItem: Int, CaseIterable {
    case inputNew = 0, checkAgain, nextButton
}

class NewPasswordView: UIView {
    
    var nextAction: (() -> Void)?
    
    private var newPasswordText: String = ""
    
    private var checkAgainText: String = ""

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
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
    
    private func checkText() -> Bool {
        return newPasswordText == checkAgainText ? true : false
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewPasswordView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NewPasswordItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let titleView = TitleHeaderView()
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        switch NewPasswordItem(rawValue: section) {
        case .inputNew: titleView.configureTitle(with: "輸入新密碼")
        case .checkAgain: titleView.configureTitle(with: "再次確認你的密碼")
        case .nextButton: return nil
        case .none: return nil
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch NewPasswordItem(rawValue: section) {
        case .inputNew: return 45
        case .checkAgain: return 45
        case .nextButton: return 20
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch NewPasswordItem(rawValue: section) {
        case .inputNew: return 100
        case .checkAgain: return 0
        case .nextButton: return 0
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch NewPasswordItem(rawValue: section) {
        case .inputNew:
            let passwordHintView = PasswordHintView()
            return passwordHintView
        case .checkAgain: return nil
        case .nextButton: return nil
        case .none: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch NewPasswordItem(rawValue: section) {
        case .inputNew: return 1
        case .checkAgain: return 1
        case .nextButton: return 1
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch NewPasswordItem(rawValue: indexPath.section) {
        case .inputNew:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
            cell.passwordConfigure(isLocked: false, isPrevented: true, placeholdText: "6-18位數密碼,請區分大小寫")
            cell.inputAction = { text in
                self.newPasswordText = text
            }
            return cell
        case .checkAgain:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
            cell.passwordConfigure(isLocked: false, isPrevented: true, placeholdText: "6-18位數密碼,請區分大小寫")
            cell.inputAction = { text in
                self.checkAgainText = text
            }
            return cell
        case .nextButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
            cell.button.setTitleColor(checkText() ? .white : .grayTextColor, for: .normal)
            cell.button.backgroundColor = checkText() ? .brownColor : .whiteGrayColor
            cell.configure(buttonName: "下一步")
            cell.action = {
                self.nextAction?()
            }
            return cell
        case .none: return UITableViewCell()
        }
    }
    
    
    
    
}
