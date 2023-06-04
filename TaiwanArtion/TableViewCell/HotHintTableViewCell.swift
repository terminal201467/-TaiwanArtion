//
//  HotHintTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/3.
//

import UIKit

class HotHintTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "HotHintTableViewCell"
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func autoLayout() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(title: String, isSelected: Bool) {
        
    }
    
}

extension HotHintTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
}
