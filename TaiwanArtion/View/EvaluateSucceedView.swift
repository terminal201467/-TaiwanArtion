//
//  EvaluateSucceedView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class EvaluateSucceedView: UIView {

    //MARK: - Background
    private let pointBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PointBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "evaluateSuccessTopRightBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "evaluateSuccessfulBottomLeftBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let middleCheersImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cheers")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Foreground
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .brownTitleColor
        label.text = "評價成功"
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .grayTextColor
        label.text = "感謝您的分享，造福了其他早找展覽的使用者！"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
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
    
    private func backgroundAutoLayout() {
        
        addSubview(topImage)
        topImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(bottomImage)
        bottomImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(pointBackground)
        pointBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(middleCheersImage)
        middleCheersImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func foregroundAutoLayout() {
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(middleCheersImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
}
