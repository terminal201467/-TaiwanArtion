//
//  RegisterStepCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit

class RegisterStepCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "RegisterStepCollectionViewCell"
    
    private let currentStepImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stepNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let stepTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .brownTitleColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func autoLayout() {
        contentView.addSubview(currentStepImage)
        currentStepImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        currentStepImage.addSubview(stepNumberLabel)
        stepNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(stepTitleLabel)
        stepTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(currentStepImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(isCurrentStep: Bool, step: Int, stepTitle: String) {
        currentStepImage.image = .init(named: isCurrentStep ? "brownCircle" : "grayCircle")
        stepNumberLabel.text = "\(step)"
        stepTitleLabel.text = stepTitle
        stepTitleLabel.textColor = isCurrentStep ? .brownTitleColor : .grayTextColor
    }
}
