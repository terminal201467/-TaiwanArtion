//
//  ResetView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit

enum ResetItem: Int, CaseIterable {
    case hint = 0, phoneVerifyCode, nextButton
}

class ResetView: UIView {
    
    private var verifyCode: String = ""
    
    var nextStep: (() -> Void)?

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(HintTableViewCell.self, forCellReuseIdentifier: HintTableViewCell.reuseIdentifier)
        tableView.register(SendVerifyTextFieldTableViewCell.self, forCellReuseIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
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
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ResetView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ResetItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch ResetItem(rawValue: section) {
        case .hint: return 20
        case .phoneVerifyCode: return 45
        case .nextButton: return 0
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let titleView = TitleHeaderView()
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        switch ResetItem(rawValue: section) {
        case .hint: return nil
        case .phoneVerifyCode: titleView.configureTitle(with: "手機驗證碼")
        case .nextButton: return nil
        case .none: return nil
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch ResetItem(rawValue: section) {
        case .hint: return nil
        case .phoneVerifyCode:
            let view = PasswordHintFooterView()
            view.forgetpasswordButton.isHidden = true
            view.configure(hint: "")
            return view
        case .nextButton: return nil
        case .none: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ResetItem(rawValue: section) {
        case .hint: return 1
        case .phoneVerifyCode: return 1
        case .nextButton: return 1
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ResetItem(rawValue: indexPath.section) {
        case .hint:
            let cell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.reuseIdentifier, for: indexPath) as! HintTableViewCell
            cell.configure(hintText: "已發送手機驗證碼至0912*********手機,請輸入手機驗證碼並送出驗證。")
            return cell
        case .phoneVerifyCode:
            let cell = tableView.dequeueReusableCell(withIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! SendVerifyTextFieldTableViewCell
            cell.configure(placeHolder: "請輸入手機驗證碼")
            cell.inputAction = { text in
                self.verifyCode = text
                self.tableView.reloadData()
            }
            cell.sendAction = {
                //告訴ViewModel要驗證碼
            }
            cell.timeTickAction = { time in
                self.tableView.reloadData()
            }
            return cell
        case .nextButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
            cell.configure(buttonName: "下一步")
            cell.button.backgroundColor = verifyCode != "" ? .brownTitleColor : .whiteGrayColor
            cell.button.setTitleColor(verifyCode != "" ? .white : .grayTextColor, for: .normal)
//            cell.button.isEnabled = verifyCode != "" ? false : true
            cell.action = {
                self.nextStep?()
            }
            return cell
        case .none: return UITableViewCell()
        }
    }
}
