//
//  HeadPhotoCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/7.
//

import UIKit

class HeadPhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HeadPhotoCollectionViewCell"
    
    private let headImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        contentView.addSubview(headImage)
        headImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(imageString: String, isSelected: Bool) {
        headImage.image = UIImage(named: imageString)
        headImage.alpha = isSelected ? 0.5 : 1
        headImage.addBorder(borderWidth: isSelected ? 0 : 1, borderColor: .brownColor)
    }
    
    func configure(imageData: Data, isSelected: Bool) {
        headImage.image = UIImage(data: imageData)
        headImage.alpha = isSelected ? 0.5 : 1
        headImage.addBorder(borderWidth: isSelected ? 0 : 1, borderColor: .brownColor)
    }
}
