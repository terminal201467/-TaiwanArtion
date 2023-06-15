//
//  WelcomeRegisterHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit

class WelcomeRegisterHeaderView: UIView {

    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .brownTitleColor
        label.textAlignment = .left
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, subTitle])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func configure(titleText: String, subTitleText: String) {
        title.text = titleText
        subTitle.text = subTitleText
    }
}
