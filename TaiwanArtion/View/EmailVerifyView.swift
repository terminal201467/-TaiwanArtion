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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(HintTableViewCell.self, forCellReuseIdentifier: HintTableViewCell.reuseIdentifier)
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
    
    private func setButtonAllowAction() {
        
    }
    
    private func autoLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension EmailVerifyView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hintCell = tableView.dequeueReusableCell(withIdentifier: HintTableViewCell.reuseIdentifier, for: indexPath) as! HintTableViewCell
        let inputCell = tableView.dequeueReusableCell(withIdentifier: InputTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputTextFieldTableViewCell
        let sendVerifyCell = tableView.dequeueReusableCell(withIdentifier: SendVerifyTextFieldTableViewCell.reuseIdentifier, for: indexPath) as! SendVerifyTextFieldTableViewCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
        let cellInfo = viewModel.cellForRowAt(indexPath: indexPath)
        switch viewModel.getCurrentStep() {
        case .stepOne:
            switch EmailVerifyCell(rawValue: indexPath.row) {
            case .hint: hintCell.configure(hintText: cellInfo)
            case .email:
                inputCell.inputAction = { inputText in
                    self.viewModel.inputText = inputText
                    if self.viewModel.isAllowSelectedNextButton {
                        buttonCell.button.backgroundColor = .brownColor
                        buttonCell.button.isEnabled = true
                        buttonCell.button.setTitleColor(.white, for: .normal)
                    } else {
                        buttonCell.button.backgroundColor = .whiteGrayColor
                        buttonCell.button.isEnabled = false
                        buttonCell.button.setTitleColor(.grayTextColor, for: .normal)
                    }
                }
                inputCell.generalConfigure(placeholdText: cellInfo)
            case .nextButton:
                buttonCell.action = {
                    //寄送電子
                    self.viewModel.setCurrentStep(step: .stepTwo)
                }
                buttonCell.configure(buttonName: cellInfo)
            case .none: break
            }
        case .stepTwo:
            switch EmailVerifyCell(rawValue: indexPath.row) {
            case .hint: hintCell.configure(hintText: cellInfo)
            case .email:
                sendVerifyCell.inputAction = { inputText in
                    self.viewModel.inputText = inputText
                    if self.viewModel.isAllowSelectedNextButton {
                        buttonCell.button.backgroundColor = .brownColor
                        buttonCell.button.isEnabled = true
                        buttonCell.button.setTitleColor(.white, for: .normal)
                    } else {
                        buttonCell.button.backgroundColor = .whiteGrayColor
                        buttonCell.button.isEnabled = false
                        buttonCell.button.setTitleColor(.grayTextColor, for: .normal)
                    }
                }
                sendVerifyCell.sendAction = {
                    //ViewModel寄送信件
                }
            case .nextButton:
                buttonCell.action = {
                    
                }
                buttonCell.configure(buttonName: cellInfo)
            case .none: break
            }
        }
        return hintCell
        return inputCell
        return sendVerifyCell
        return buttonCell
    }
}
