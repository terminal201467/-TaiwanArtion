//
//  InputTextFieldTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit
import RxSwift
import RxCocoa

class InputTextFieldTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "InputTextFieldTableViewCell"

    private let disposeBag = DisposeBag()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .grayTextColor
        textField.roundCorners(cornerRadius: 12)
        return textField
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private let fogetHintButton: UIButton = {
        let button = UIButton()
        button.setTitle("忘記密碼", for: .normal)
        button.setTitleColor(.brownTitleColor, for: .normal)
        button.isHidden = true
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(fogetHintButton)
        fogetHintButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(textField.snp.bottom)
        }
        
        contentView.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.leading)
            make.top.equalTo(textField.snp.bottom)
        }
    }
    
    func accountConfigure(placeholderText: String) {
        textField.leftView = UIImageView(image: .init(named: "person"))
        textField.placeholder = placeholderText
    }
    
    func passwordConfigure(isLocked: Bool, isPrevented: Bool, placeholdText: String) {
        textField.leftView = UIImageView(image: .init(named: isLocked ? "redLock" : "lock"))
        textField.rightView = UIImageView(image: .init(named: isPrevented ? "passwordPrevent" : ""))
        textField.placeholder = placeholdText
    }
}
