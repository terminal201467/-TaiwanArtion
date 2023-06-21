//
//  AccountPasswordView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit
import RxSwift
import RxCocoa

enum AccountPasswordSection: Int, CaseIterable {
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
    
    var account: String = ""
    
    var password: String = ""
    
    private let disposeBag = DisposeBag()
    
    //檢查邏輯ViewModel
    private let viewModel = AccountPasswordViewModel()
    
    private let contentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(PhoneNumberInputTableViewCell.self, forCellReuseIdentifier: PhoneNumberInputTableViewCell.reuseIdentifier)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(SendVerifyTextFieldTableViewCell.self, forCellReuseIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier)
        tableView.register(StrengthTableViewCell.self, forCellReuseIdentifier: StrengthTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
        setBinding()
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
    
    private func setBinding() {
        viewModel.outputs
            .loginSuccess
            .emit(onNext: { [weak self] employeeName in
                // 登入成功，您可以在這裡處理登入成功後的相應邏輯
                // ...
            })
            .disposed(by: disposeBag)
    }
    
    private func login(account: String, password: String) {
        viewModel.inputs
            .onLogin
            .accept((account, password))
    }
    
    private func setButtonSelection(button: UIButton, isInputText: Bool) {
        button.backgroundColor = isInputText ? .whiteGrayColor : .brownColor
        button.setTitleColor(isInputText ? .grayTextColor : .white, for: .normal)
        button.isEnabled = isInputText ? false : true
    }
    
}

extension AccountPasswordView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AccountPasswordSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let titleView = TitleHeaderView()
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        switch AccountPasswordSection(rawValue: section) {
        case .account:
            titleView.configureTitle(with: AccountPasswordSection.account.sectionHeaderText)
            return containerView
        case .password:
            titleView.configureTitle(with: AccountPasswordSection.password.sectionHeaderText)
            return containerView
        case .passwordHint: return nil
        case .strengthHint: return nil
        case .nextButton: return nil
        case .none: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch AccountPasswordSection(rawValue: section) {
        case .account: return 1
        case .password: return 1
        case .passwordHint: return 1
        case .strengthHint: return 1
        case .nextButton: return 1
        case .none: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch AccountPasswordSection(rawValue: indexPath.section) {
        case .account:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
            inputCell.inputAction = { inputText in
                self.account = inputText
                tableView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
            }
            inputCell.accountConfigure(placeholderText: "4-21碼大小寫英文數字")
            return inputCell
        case .password:
            let inputCell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
            inputCell.inputAction = { inputText in
                self.password = inputText
                tableView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
            }
            inputCell.passwordConfigure(isLocked: false, isPrevented: true, placeholdText: "6-18位數密碼，請區分大小寫")
            return inputCell
        case .passwordHint:
            let passwordContainerCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
            let passwordHintView = PasswordHintView()
            passwordContainerCell.contentView.addSubview(passwordHintView)
            passwordHintView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.height.equalTo(50)
            }
            tableView.reloadRows(at: [indexPath], with: .none)
            return passwordContainerCell
        case .strengthHint:
            let strengthCell = tableView.dequeueReusableCell(withIdentifier: StrengthTableViewCell.reuseIdentifier, for: indexPath) as! StrengthTableViewCell
            strengthCell.configure(condition: 3)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return strengthCell
        case .nextButton:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
            setButtonSelection(button: buttonCell.button, isInputText: account == "" || password == "")
            buttonCell.action = {
                self.login(account: self.account, password: self.password)
                self.toNextStep?()
            }
            buttonCell.configure(buttonName: "下一步")
            return buttonCell
        case .none: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch AccountPasswordSection(rawValue: indexPath.section) {
        case .account: return UITableView.automaticDimension
        case .password: return UITableView.automaticDimension
        case .passwordHint: return 100
        case .strengthHint: return 50
        case .nextButton: return UITableView.automaticDimension
        case .none: return 0
        }
        return 0
    }
}
