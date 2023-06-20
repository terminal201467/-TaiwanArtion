//
//  SendVerifyTextFieledTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit
import RxSwift
import RxCocoa

class SendVerifyTextFieldTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "SendVerifyTextFieldTableViewCell"
    
    private let disposeBag = DisposeBag()
    
    var sendAction: (() -> (Void))?
    
    var inputAction: ((String) -> (Void))?
    
    private var isSend: Bool = false
    
    private let timer = CountdownTimer(timeInterval: 60)

    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .grayTextColor
        textField.roundCorners(cornerRadius: 12)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let sendVerifyButton: UIButton = {
        let button = UIButton()
        button.roundCorners(cornerRadius: 12)
        return button
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private lazy var inputerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, sendVerifyButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.delegate = self
        setSubscribeButton()
        autoLayout()
        setSendButton()
        setTime()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubscribeButton() {
        sendVerifyButton.rx.tap
            .subscribe(onNext: {
                self.sendAction?()
                //這邊要計時60s
                self.timer.start()
                self.isSend = true
                //對Firebase送出簡訊申請
            })
            .disposed(by: disposeBag)
    }
    
    private func setTime() {
        if timer.timeRemaining == 0 {
            self.isSend = false
        }
    }

    private func autoLayout() {
        contentView.addSubview(inputerStack)
        inputerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(40.0)
        }
        
        sendVerifyButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(40.0)
        }
        
        contentView.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.leading.equalTo(textField.snp.leading)
        }
    }
    
    private func setSendButton() {
        sendVerifyButton.backgroundColor = isSend ? .whiteGrayColor : .brownColor
        sendVerifyButton.setTitleColor(isSend ? .grayTextColor : .brownColor, for: .normal)
        sendVerifyButton.setTitle(isSend ? "\(timer.timeRemaining)s,重新發送" : "發送驗證碼", for: .normal)
        sendVerifyButton.isEnabled = isSend ? false : true
    }
}

extension SendVerifyTextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.inputAction?(textField.text ?? "")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
