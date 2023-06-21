//
//  NumberInputTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit
import RxSwift

class PhoneNumberInputTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "NumberInputTableViewCell"
    
    private let disposeBag = DisposeBag()
    
    var inputAction: ((String) -> (Void))?
    
    private let countryBannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let preTelePhoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let downArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "downArrow"), for: .normal)
        return button
    }()
    
    private lazy var contactStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryBannerImage, preTelePhoneLabel, downArrowButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 3
        return stackView
    }()
    
    private let containerView: UIView = {
       let view = UIView()
        view.roundCorners(cornerRadius: 12)
        view.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        view.backgroundColor = .white
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .grayTextColor
        textField.borderStyle = .roundedRect
        textField.roundCorners(cornerRadius: 12)
        textField.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "請輸入手機號碼"
        return textField
    }()
    
    private lazy var inputStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactStack, textField])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setTextFieldDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTextFieldDelegate() {
        textField.delegate = self
        textField.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                self.inputAction?(text)
            })
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        contentView.addSubview(inputStack)
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalTo(90.0)
            make.height.equalTo(40.0)
        }
        
        containerView.addSubview(contactStack)
        contactStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        inputStack.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func configure(preTeleNumber: String, country: String) {
        countryBannerImage.image = UIImage.init(named: country)
        preTelePhoneLabel.text = preTeleNumber
    }
}

extension PhoneNumberInputTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputAction?(textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        inputAction?(textField.text!)
        textField.becomeFirstResponder()
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
