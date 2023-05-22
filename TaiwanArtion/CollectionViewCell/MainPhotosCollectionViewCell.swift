//
//  MainPhotosCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import UIKit

class MainPhotosCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "MainPhotosCollectionViewCell"
    
    private let exhibitionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .tagYellowColor
        label.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner], radius: 8)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        label.textAlignment = .left
        return label
    }()
    
    private let collectButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var titleInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
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
        addSubview(exhibitionImage)
        exhibitionImage.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(283.0 / 390.0)
            make.height.equalToSuperview().multipliedBy(160.0 / 844.0)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(exhibitionImage.snp.leading)
            make.bottom.equalTo(exhibitionImage.snp.bottom)
            make.height.equalToSuperview().multipliedBy(24.0 / 844.0)
            make.width.equalToSuperview().multipliedBy(40.0 / 390.0)
        }
        
        addSubview(titleInfoStack)
        titleInfoStack.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImage.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(collectButton)
        collectButton.snp.makeConstraints { make in
            make.width.equalTo(23)
            make.height.equalTo(23)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
     func configure(title: String, date: String, tagText: String, image: String) {
        titleLabel.text = title
        dateLabel.text = date
        tagLabel.text = tagText
        exhibitionImage.image = UIImage(named: image)
    }
}
