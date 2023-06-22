//
//  EmailVerifyView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit



class EmailVerifyView: UIView {
    
    private let viewModel = EmailVerifyViewModel()
    
    var toNextStep: (() -> Void)?

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(HintTableViewCell.self, forCellReuseIdentifier: HintTableViewCell.reuseIdentifier)
        tableView.register(SendVerifyTextFieldTableViewCell.self, forCellReuseIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier)
        tableView.allowsSelection = false
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
    
    private func setButtonAllowAction() {
        
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setSelectionButton(button: UIButton, isAllowSelection: Bool) {
        button.backgroundColor = isAllowSelection ? .brownColor : .whiteGrayColor
        button.isEnabled = isAllowSelection ? true : false
        button.setTitleColor(isAllowSelection ? .white : .grayTextColor, for: .normal)
    }
}

extension EmailVerifyView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let titleView = TitleHeaderView()
        containerView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        switch EmailVerifySection(rawValue: section) {
        case .hint: return nil
        case .email:
            switch viewModel.getCurrentStep() {
            case .stepOne: titleView.configureTitle(with: EmailVerifySection.email.stepOneText)
            case .stepTwo: titleView.configureTitle(with: EmailVerifySection.email.stepTwoText)
            }
        case .nextButton: return nil
        case .none: return nil
        }
        return containerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellInfo = viewModel.cellForRowAt(indexPath: indexPath)
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
        switch EmailVerifySection(rawValue: indexPath.section) {
        case .hint:
            let hintCell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.reuseIdentifier, for: indexPath) as! HintTableViewCell
            switch viewModel.getCurrentStep() {
            case .stepOne: hintCell.configure(hintText: EmailVerifySection.hint.stepOneText)
            case .stepTwo: hintCell.configure(hintText: EmailVerifySection.hint.stepTwoText)
            }
            return hintCell
        case .email:
            switch viewModel.getCurrentStep() {
            case .stepOne:
                let inputCell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
                inputCell.inputAction = { inputText in
                    self.viewModel.inputText = inputText
                }
                inputCell.generalConfigure(placeholdText: "請輸入電子信箱")
                return inputCell
            case .stepTwo:
                let sendVerifyCell = tableView.dequeueReusableCell(withIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! SendVerifyTextFieldTableViewCell
                sendVerifyCell.configure(placeHolder: "信箱驗證碼")
                sendVerifyCell.sendAction = {
                    
                }
                
                sendVerifyCell.inputAction = { text in
                    
                }
                
                sendVerifyCell.timeTickAction = { second in
                    
                }
                return sendVerifyCell
            }
        case .nextButton:
            switch viewModel.getCurrentStep() {
            case .stepOne:
                buttonCell.action = {
                    //寄送電子
                    self.viewModel.setCurrentStep(step: .stepTwo)
                    tableView.reloadData()
                }
                buttonCell.configure(buttonName: EmailVerifySection.nextButton.stepOneText)
            case .stepTwo:
                buttonCell.action = {
                    //寄送電子
                    self.toNextStep?()
                }
                buttonCell.configure(buttonName: EmailVerifySection.nextButton.stepTwoText)
            }
            return buttonCell
        case .none: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch EmailVerifySection(rawValue: indexPath.section) {
        case .hint: return UITableView.automaticDimension
        case .email: return 70
        case .nextButton: return 50
        case .none: return 0
        }
    }
}
