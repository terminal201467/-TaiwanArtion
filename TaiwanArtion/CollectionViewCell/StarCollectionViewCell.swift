//
//  StarCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit

class StarCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "StarCollectionViewCell"
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "grayStar")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(starImage)
        starImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(isValueStar: Bool) {
        starImage.image = UIImage(named: isValueStar ? "star" : "grayStar")
    }
}
