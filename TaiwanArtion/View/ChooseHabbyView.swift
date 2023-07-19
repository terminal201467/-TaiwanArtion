//
//  ChooseHabbyView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/18.
//

import UIKit

class ChooseHabbyView: UIView {
    
    //MARK: Background
    private let lineImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "chooseHabbyPageline"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomLeftPageImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "bottomLeftPageImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Foreground
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HabbyCollectionViewCell.self, forCellWithReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier)
        collectionView.register(HintCollectionViewCell.self, forCellWithReuseIdentifier: HintCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        collectionView.backgroundColor = nil
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        backgroundColor = .caramelColor
        addSubview(lineImage)
        lineImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        addSubview(bottomLeftPageImage)
        bottomLeftPageImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
