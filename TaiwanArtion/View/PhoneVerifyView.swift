//
//  PhoneVerifyView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit

enum PhoneVerifyCell: Int, CaseIterable {
    case hint = 0, verify, nextButton
    var stepOneText: String {
        switch self {
        case .hint: return "為了確保是你本人，我們將會寄送一封驗證簡訊到你的手機。"
        case .verify: return "手機號碼"
        case .nextButton: return "下一步"
        }
    }
    var stepTwoText: String {
        switch self {
        case .hint: return "已發送手機驗證碼至0912*********手機,請輸入手機驗證碼並送出驗證。"
        case .verify: return "手機驗證碼"
        case .nextButton: return "驗證手機號碼"
        }
    }
}

enum PhoneVerifyStep: Int, CaseIterable {
    case stepOne = 0, stepTwo
}

class PhoneVerifyView: UIView {
    
    var toNextStep: (() -> Void)?
    
    private var currentStep: PhoneVerifyStep = .stepOne

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
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(contentTableView)
        contentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension PhoneVerifyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhoneVerifyCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TitleHeaderView()
        switch currentStep {
        case .stepOne: view.configureTitle(with: PhoneVerifyCell.verify.stepOneText)
        case .stepTwo: view.configureTitle(with: PhoneVerifyCell.verify.stepTwoText)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hintCell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.reuseIdentifier, for: indexPath) as! HintTableViewCell
        let verifyCell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberInputTableViewCell.reuseIdentifier, for: indexPath) as! PhoneNumberInputTableViewCell
        let nextButtonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
        let sendVerifyCell = tableView.dequeueReusableCell(withIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! SendVerifyTextFieldTableViewCell
        switch currentStep {
        case .stepOne:
            switch PhoneVerifyCell(rawValue: indexPath.row) {
            case .hint:
                hintCell.configure(hintText: PhoneVerifyCell.hint.stepOneText)
            case .verify:
                verifyCell.configure(preTeleNumber: "+886", country: "roc")
                verifyCell.inputAction = { text in
                    print("text:\(text)")
                    nextButtonCell.button.backgroundColor = text != "" ? .whiteGrayColor : .brownColor
                    nextButtonCell.configure(buttonName: text != "" ? PhoneVerifyCell.nextButton.stepOneText : PhoneVerifyCell.nextButton.stepTwoText)
                    nextButtonCell.button.isEnabled = text != "" ? false : true
                }
            case .nextButton:
                nextButtonCell.configure(buttonName: PhoneVerifyCell.nextButton.stepOneText)
            case .none: break
            }
        case .stepTwo:
            switch PhoneVerifyCell(rawValue: indexPath.row) {
            case .hint:
                hintCell.configure(hintText: PhoneVerifyCell.hint.stepTwoText)
            case .verify:
                sendVerifyCell.inputAction = { text in
                    print("text:\(text)")
                    nextButtonCell.button.backgroundColor = text != "" ? .brownColor : .white
                    nextButtonCell.button.setTitleColor(text != "" ? .white : .brownColor, for: .normal)
                    nextButtonCell.button.isEnabled = text != "" ? false : true
                }
            case .nextButton:
                nextButtonCell.configure(buttonName: PhoneVerifyCell.nextButton.stepTwoText)
                nextButtonCell.action = {
                    print("verify")
                    self.toNextStep?()
                    //驗證手機號碼的相關Code
                }
            case .none: break
            }
        }
        return hintCell
        return verifyCell
        return nextButtonCell
        return sendVerifyCell
    }
    
    
}

