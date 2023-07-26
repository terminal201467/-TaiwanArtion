//
//  FlexibleTabBarCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/26.
//

import UIKit

class FlexibleTabBarCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "FlexibleTabBarCollectionViewCell"
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var logoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImage, label])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(logoStack)
        logoStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(image: String, selectedImage: String, text: String, isSelected: Bool) {
        logoImage.image = .init(named: isSelected ? selectedImage : image)
        label.text = text
        label.textColor = isSelected ? .brownTitleColor : .grayTextColor
    }
}
