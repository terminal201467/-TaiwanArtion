//
//  NewsSearchingView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/28.
//

import UIKit

class NewsSearchingView: UIView {

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MonthsHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: MonthsHorizontalCollectionViewCell.reuseIdentifier)
        collectionView.register(FilterNewsHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: FilterNewsHorizontalCollectionViewCell.reuseIdentifier)
        collectionView.register(HabbyCollectionViewCell.self, forCellWithReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(TitleCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableHeaderView.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 20)
        collectionView.applyShadow(color: .black, opacity: 0.1, offset: CGSize(width: 0.5, height: 0.5), radius: 1)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewAutoLayout() {
        backgroundColor = .caramelColor
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
