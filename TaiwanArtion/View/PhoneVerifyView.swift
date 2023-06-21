//
//  PhoneVerifyView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit

enum PhoneHintCell: Int, CaseIterable {
    case hint = 0
    var stepOne: String {
        switch self {
        case .hint: return "為了確保是你本人，我們將會寄送一封驗證簡訊到你的手機。"
        }
    }
    
    var stepTwo: String {
        switch self {
        case .hint: return "已發送手機驗證碼至0912*********手機,請輸入手機驗證碼並送出驗證。"
        }
    }
}

enum PhoneVerifyCell: Int, CaseIterable {
    case verify = 0, nextButton
    var stepOneText: String {
        switch self {
        case .verify: return "手機號碼"
        case .nextButton: return "寄送手機驗證碼"
        }
    }
    var stepTwoText: String {
        switch self {
        case .verify: return "手機驗證碼"
        case .nextButton: return "驗證手機號碼"
        }
    }
}

enum SectionHeader: Int, CaseIterable {
    case hintHeader = 0, phoneNumber
}

enum PhoneVerifyStep: Int, CaseIterable {
    case stepOne = 0, stepTwo
}

class PhoneVerifyView: UIView {
    
    var toNextStep: (() -> Void)?
    
    private var inputText: String = "" {
        didSet {
            contentTableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .none)
        }
    }
    
    private var currentStep: PhoneVerifyStep = .stepOne

    private let contentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(PhoneNumberInputTableViewCell.self, forCellReuseIdentifier: PhoneNumberInputTableViewCell.reuseIdentifier)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(SendVerifyTextFieldTableViewCell.self, forCellReuseIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier)
        tableView.register(HintTableViewCell.self, forCellReuseIdentifier: HintTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.roundCorners(cornerRadius: 20)
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
    
    private func setButtonSelection(button: UIButton, isInputText: Bool) {
        button.backgroundColor = isInputText ? .whiteGrayColor : .brownColor
        button.setTitleColor(isInputText ? .grayTextColor : .white, for: .normal)
        button.isEnabled = isInputText ? false : true
    }
}

extension PhoneVerifyView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SectionHeader(rawValue: section) {
        case .hintHeader: return 1
        case .phoneNumber: return 2
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
            make.height.equalTo(30)
        }
        switch SectionHeader(rawValue: section) {
        case .hintHeader: return UIView()
        case .phoneNumber:
            switch currentStep {
            case .stepOne:
                titleView.configureTitle(with: PhoneVerifyCell.verify.stepOneText)
                return containerView
            case .stepTwo:
                titleView.configureTitle(with: PhoneVerifyCell.verify.stepTwoText)
                return containerView
            }
        case .none: return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionHeader(rawValue: indexPath.section) {
        case .hintHeader:
            let hintCell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.reuseIdentifier, for: indexPath) as! HintTableViewCell
            switch currentStep {
            case .stepOne: hintCell.configure(hintText: PhoneHintCell.hint.stepOne)
            case .stepTwo: hintCell.configure(hintText: PhoneHintCell.hint.stepTwo)
            }
            return hintCell
        case .phoneNumber:
            switch PhoneVerifyCell(rawValue: indexPath.row) {
            case .verify:
                switch currentStep {
                case .stepOne:
                    let verifyCell = tableView.dequeueReusableCell(withIdentifier: PhoneNumberInputTableViewCell.reuseIdentifier, for: indexPath) as! PhoneNumberInputTableViewCell
                    verifyCell.configure(preTeleNumber: "+886", country: "roc")
                    verifyCell.inputAction = { text in
                        self.inputText = text
                    }
                    return verifyCell
                case .stepTwo:
                    let sendVerifyCell = tableView.dequeueReusableCell(withIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! SendVerifyTextFieldTableViewCell
                    sendVerifyCell.configure(placeHolder: "請輸入手機驗證碼")
                    sendVerifyCell.inputAction = { text in
                        self.inputText = text
                    }
                    sendVerifyCell.sendAction = {
                        tableView.reloadRows(at: [indexPath], with: .none)
                    }
                    sendVerifyCell.timeTickAction = { second in
                        sendVerifyCell.setSendButton(timeRemaining: second)
                        tableView.reloadRows(at: [indexPath], with: .none)
                    }
                    return sendVerifyCell
                }
            case .nextButton:
                let nextButtonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
                switch currentStep {
                case .stepOne:
                    nextButtonCell.configure(buttonName: inputText == "" ? PhoneVerifyCell.nextButton.stepOneText : PhoneVerifyCell.nextButton.stepOneText)
                    setButtonSelection(button: nextButtonCell.button, isInputText: inputText == "")
                    nextButtonCell.action = {
                        self.currentStep = .stepTwo
                        tableView.reloadData()
                    }
                    return nextButtonCell
                case .stepTwo:
                    nextButtonCell.configure(buttonName: inputText == "" ? PhoneVerifyCell.nextButton.stepOneText : PhoneVerifyCell.nextButton.stepTwoText)
                    setButtonSelection(button: nextButtonCell.button, isInputText: inputText == "")
                    nextButtonCell.action = {
                        self.toNextStep?()
                    }
                    return nextButtonCell
                }

            case .none: return UITableViewCell()
            }
        case .none: return UITableViewCell()
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SectionHeader(rawValue: indexPath.section) {
        case .hintHeader: return UITableView.automaticDimension
        case .phoneNumber: return 70
        case .none: return 0
        }
    }
}

