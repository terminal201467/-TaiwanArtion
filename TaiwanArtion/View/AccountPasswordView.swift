//
//  AccountPasswordView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    private let disposeBag = DisposeBag()
    
    //檢查邏輯ViewModel
    private let viewModel: LoginViewModelType!
    
    public init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    private let contentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(PhoneNumberInputTableViewCell.self, forCellReuseIdentifier: PhoneNumberInputTableViewCell.reuseIdentifier)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(SendVerifyTextFieldTableViewCell.self, forCellReuseIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier)
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
        case .account: return 1
        case .password: return 1
        case .passwordHint: return 1
        case .strengthHint: return 1
        case .nextButton: return 1
        case .none: break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
        let passwordContainerCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
        let strengthCell = tableView.dequeueReusableCell(withIdentifier: StrengthTableViewCell.reuseIdentifier, for: indexPath) as! StrengthTableViewCell
        switch AccountPasswordCell(rawValue: indexPath.row) {
        case .account:
            cell.inputAction = { inputText in
                
            }
            cell.accountConfigure(placeholderText: "4-21碼大小寫英文數字")
            return cell
        case .password:
            cell.inputAction = { inputText in
                
            }
            cell.passwordConfigure(isLocked: false, isPrevented: true, placeholdText: "6-18位數密碼，請區分大小寫")
            return cell
        case .passwordHint:
            let passwordHintView = PasswordHintView()
            passwordContainerCell.contentView.addSubview(passwordHintView)
            return passwordContainerCell
        case .strengthHint:
            strengthCell.configure(condition: 3)
            return strengthCell
        case .nextButton:
            buttonCell.action = {
                
            }
            buttonCell.configure(buttonName: "下一步")
            return buttonCell
        case .none: break
        }
    }
}
