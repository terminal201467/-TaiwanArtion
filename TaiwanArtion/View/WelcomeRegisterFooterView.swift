//
//  WelcomeRegisterFooterView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit
import RxSwift
import RxCocoa

class WelcomeRegisterFooterView: UIView {
    
    var facebookRegister: (() -> (Void))?
    
    var googleRegister: (() -> (Void))?
    
    var lineRegister: (() -> (Void))?
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Line
    private let leftGrayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayTextColor
        return view
    }()
    
    private let rightGrayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayTextColor
        return view
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "或者使用以下帳號登入/註冊"
        label.textColor = .grayTextColor
        return label
    }()
    
    //MARK: - ButtonStack
    private let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "facebookIcon"), for: .normal)
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "googleIcon"), for: .normal)
        return button
    }()
    
    private let lineButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "lineIcon"), for: .normal)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [facebookButton, googleButton, lineButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subscribeButton()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subscribeButton() {
        facebookButton.rx.tap
            .subscribe(onNext: {
                self.facebookRegister?()
            })
            .disposed(by: disposeBag)
        googleButton.rx.tap
            .subscribe(onNext: {
                self.googleRegister?()
            })
            .disposed(by: disposeBag)
        
        lineButton.rx.tap
            .subscribe(onNext: {
                self.lineRegister?()
            })
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(leftGrayLineView)
        leftGrayLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(hintLabel.snp.leading).offset(-10)
            make.centerY.equalTo(hintLabel.snp.centerY)
        }
        
        addSubview(rightGrayLineView)
        rightGrayLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(hintLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(hintLabel.snp.centerY)
        }
        
        addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hintLabel.snp.bottom).offset(10)
        }
    }
    
}
