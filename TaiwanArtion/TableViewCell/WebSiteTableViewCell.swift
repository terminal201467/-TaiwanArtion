//
//  WebSiteTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/2.
//

import UIKit

class WebSiteTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let linkTextButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.grayTextColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return button
    }()
    
    private let imageButton: UIButton = {
        let button = UIButton()
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return button
    }()
    
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: <#T##[UIView]#>)
//        stackView.axis =
//        stackView.alignment =
//        stackView.distribution =
//        stackView.spacing =
//        return stackView
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
//        addSubview(labelStack)
//        labelStack.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(16)
//        }
//
//        contentLabel.snp.makeConstraints { make in
//            make.width.greaterThanOrEqualTo(56.0)
//            make.height.equalTo(24.0)
//        }
    }
    
    func configure() {
        
    }

}
