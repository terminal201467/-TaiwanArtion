//
//  AllExhibitionCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/24.
//

import UIKit

class AllExhibitionCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "AllExhibitionCollectionViewCell"
    
    private let exhibitionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let collectButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .tagYellowColor
        label.textAlignment = .center
        label.setSpecificRoundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner], radius: 8)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.lineBreakStrategy = .standard
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "near"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var dateStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, iconImage, cityLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateStack])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
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
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(180.0 / frame.height)
        }
        
        addSubview(collectButton)
        collectButton.snp.makeConstraints { make in
            make.trailing.equalTo(exhibitionImage.snp.trailing).offset(-13)
            make.top.equalTo(exhibitionImage.snp.top).offset(13)
            
        }
        
        iconImage.snp.makeConstraints { make in
            make.height.equalTo(13)
            make.width.equalTo(10)
        }
        
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImage.snp.bottom)
            make.leading.equalTo(exhibitionImage.snp.leading)
            make.trailing.equalTo(exhibitionImage.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with exhibition: ExhibitionModel) {
        exhibitionImage.image = UIImage(named: exhibition.image)
        titleLabel.text = exhibition.title
        dateLabel.text = exhibition.date
        cityLabel.text = exhibition.location
    }
    
}
