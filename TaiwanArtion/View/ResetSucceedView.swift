//
//  ResetSucceedView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/17.
//

import UIKit

class ResetSucceedView: UIView {

    //MARK: -background
    
    private let rightTopImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "resetSucceedTopRightImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let leftBottomImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "resetSucceedLeftBottom"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - foreground
    private let resetSucceedImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "resetSucceed"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let bottomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var descriptionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topDescriptionLabel, bottomDescriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func foregroundAutoLayout()  {
        addSubview(resetSucceedImage)
        resetSucceedImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(191.0)
            make.width.equalTo(264.0)
        }
        
        addSubview(descriptionStack)
        descriptionStack.snp.makeConstraints { make in
            make.top.equalTo(resetSucceedImage).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func backgroundAutoLayout() {
        addSubview(rightTopImage)
        rightTopImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(leftBottomImage)
        leftBottomImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.left.equalToSuperview()
        }
    }

}
