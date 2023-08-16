//
//  NotMemberTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class NotMemberTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "NotMemberTableViewCell"
    
    private let disposeBag = DisposeBag()
    
    var forgetAction: (() -> Void)?
    
    var registerAction: (() -> Void)?

    private let notMemberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "還不是會員嗎？"
        label.textColor = .black
        return label
    }()
    
    private let forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.brownTitleColor, for: .normal)
        button.setTitle("註冊帳號", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textColor = .brownTitleColor
        return button
    }()
    
    private lazy var hintStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [notMemberLabel, forgetPasswordButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(hintStack)
        hintStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setButton() {
        forgetPasswordButton.rx.tap
            .subscribe(onNext: {
                self.forgetAction?()
            })
            .disposed(by: disposeBag)
        
        forgetPasswordButton.rx.tap
            .subscribe(onNext: {
                self.registerAction?()
            })
            .disposed(by: disposeBag)
    }
}
