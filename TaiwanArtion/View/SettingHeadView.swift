//
//  SettingHeadView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit

class SettingHeadView: UIView {
    
    private let bottomBackgroundImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "bottomBackgroundImage")
        return imageView
    }()
    
    private let backline: UIImageView = {
        let imageView = UIImageView(image: .init(named: "backgroundLine"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HintCollectionViewCell.self, forCellWithReuseIdentifier: HintCollectionViewCell.reuseIdentifier)
        collectionView.register(HeadPhotoCollectionViewCell.self, forCellWithReuseIdentifier: HeadPhotoCollectionViewCell.reuseIdentifier)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        return collectionView
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
        backgroundColor = .caramelColor
        addSubview(backline)
        backline.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        addSubview(bottomBackgroundImage)
        bottomBackgroundImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func foregroundAutoLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
