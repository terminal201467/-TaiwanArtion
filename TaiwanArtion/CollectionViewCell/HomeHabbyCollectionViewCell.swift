//
//  HomeHabbyCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/17.
//

import UIKit

class HomeHabbyCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HomeHabbyCollectionViewCell"
    
    private let habbyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let habbyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        addSubview(habbyImage)
        habbyImage.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        addSubview(habbyLabel)
        habbyLabel.snp.makeConstraints { make in
            make.top.equalTo(habbyImage.snp.bottom)
            make.height.equalTo(18)
        }
    }
    
    func configure(imageName: String, labelText: String) {
        habbyImage.image = UIImage(named: imageName)
        habbyLabel.text = labelText
    }
}
