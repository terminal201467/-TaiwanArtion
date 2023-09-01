//
//  StrengthTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/19.
//

import UIKit

class StrengthTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "StrengthTableViewCell"

    private let passwordStrengthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let colorStrengthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let strengthSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = .sliderBrownColor
        slider.maximumTrackTintColor = .whiteGrayColor
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        return slider
    }()
    
    private lazy var strengthStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordStrengthLabel, strengthSlider])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.backgroundColor = .white
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
        contentView.backgroundColor = .white
        contentView.addSubview(strengthStack)
        strengthStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(colorStrengthLabel)
        colorStrengthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(passwordStrengthLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
    func configure(condition: Int) {
        passwordStrengthLabel.text = "密碼強度"
        if condition == 1 {
            colorStrengthLabel.textColor = .strengthRed
            colorStrengthLabel.text = "弱"
            strengthSlider.value = 3
        } else if condition >= 2 || condition < 4 {
            colorStrengthLabel.textColor = .strengthYellow
            colorStrengthLabel.text = "中"
            strengthSlider.value = 5
        } else if condition == 4 {
            colorStrengthLabel.textColor = .strengthGreen
            colorStrengthLabel.text = "強"
            strengthSlider.value = 10
        }
    }

}
