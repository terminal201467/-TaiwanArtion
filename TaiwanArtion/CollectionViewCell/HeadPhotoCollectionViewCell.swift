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
        imageView.roundCorners(cornerRadius: 10)
        return imageView
    }()
    
    let imageMaskView: UIView = {
       let view = UIView()
        view.roundCorners(cornerRadius: 10)
        return view
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
        
        contentView.addSubview(imageMaskView)
        imageMaskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(imageString: String, isSelected: Bool?) {
        if isSelected == nil {
            headImage.image = UIImage(named: imageString)
            headImage.alpha = 1
            imageMaskView.addBorder(borderWidth: 0, borderColor: .brownColor)
        } else {
            headImage.image = UIImage(named: imageString)
            headImage.alpha = isSelected! ? 0.5 : 1
            imageMaskView.addBorder(borderWidth: isSelected! ? 2 : 0, borderColor: .brownColor)
        }
    }
    
    func configure(imageString: String) {
        headImage.image = UIImage(named: imageString)
        headImage.alpha = 1
    }
    
    func configure(imageData: Data, isSelected: Bool?) {
        if isSelected == nil {
            headImage.image = UIImage(data: imageData)
            headImage.alpha = 1
            imageMaskView.addBorder(borderWidth: 0, borderColor: .brownColor)
        } else {
            headImage.image = UIImage(data: imageData)
            headImage.alpha = isSelected! ? 0.5 : 1
            imageMaskView.addBorder(borderWidth: isSelected! ? 2 : 0, borderColor: .brownColor)
        }
    }
}
