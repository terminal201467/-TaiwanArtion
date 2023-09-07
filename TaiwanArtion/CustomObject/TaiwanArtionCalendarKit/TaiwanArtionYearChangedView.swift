//
//  TaiwanArtionYearChangedView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/7.
//

import UIKit

class TaiwanArtionYearChangedView: UIView {
    
    var beforeAction: (() -> Void)?
    
    var afterAction: (() -> Void)?

    private let beforeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(before), for: .touchDown)
        return button
    }()
    
    private let afterButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(after), for: .touchDown)
        return button
    }()
    
    private let yearMonthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [beforeButton, yearMonthLabel, afterButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 24.0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func before() {
        beforeAction?()
    }
    
    @objc private func after() {
        afterAction?()
    }
    
    private func autoLayout() {
        beforeButton.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.width.equalTo(24.0)
        }
        
        afterButton.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.width.equalTo(24.0)
        }
        
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(by year: Int, by month: Int) {
        yearMonthLabel.text = "\(year)年\(month)月"
    }
}