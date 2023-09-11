//
//  TaiwanArtionMonthChangedView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/7.
//

import UIKit

class TaiwanArtionMonthChangedView: UIView {
    
    var beforeAction: (() -> Void)?
    
    var afterAction: (() -> Void)?

    private let beforeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(before), for: .touchDown)
        button.setImage(.init(named: "leftArrow"), for: .normal)
        return button
    }()
    
    private let afterButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(after), for: .touchDown)
        button.setImage(.init(named: "rightArrow"), for: .normal)
        return button
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .brown
        return label
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
        addSubview(beforeButton)
        beforeButton.snp.makeConstraints { make in
            make.height.equalTo(32.0)
            make.width.equalTo(32.0)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16.0)
        }
        
        addSubview(afterButton)
        afterButton.snp.makeConstraints { make in
            make.height.equalTo(32.0)
            make.width.equalTo(32.0)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16.0)
        }
        
        addSubview(monthLabel)
        monthLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100.0)
            make.height.equalTo(50.0)
        }
    }
    
    func configureTitle(with titleMonth: Month) {
        monthLabel.text = "\(titleMonth.numberText)\(titleMonth.englishText)"
    }
}
