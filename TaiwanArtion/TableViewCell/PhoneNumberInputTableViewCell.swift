//
//  NumberInputTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit

class PhoneNumberInputTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "NumberInputTableViewCell"
    
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
        stackView.spacing = 0
        stackView.roundCorners(cornerRadius: 12)
        stackView.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        return stackView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .grayTextColor
        textField.roundCorners(cornerRadius: 12)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(inputStack)
        inputStack.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contactStack.snp.makeConstraints { make in
            make.width.equalTo(90.0)
            make.height.equalTo(40.0)
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
        inputAction?(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputAction?(textField.text ?? "")
        textField.resignFirstResponder()
    }
    
}
