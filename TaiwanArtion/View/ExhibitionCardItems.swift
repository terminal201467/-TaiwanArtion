//
//  ExhibitionCardItems.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/25.
//

import UIKit


class ExhibitionCardItems: UIView {
    
    var chooseItem: ((CardInfoItem) -> Void)? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var currentSelectedItem: CardInfoItem = .overview

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ExhibitionCardItemCell.self, forCellWithReuseIdentifier: ExhibitionCardItemCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ExhibitionCardItems: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CardInfoItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitionCardItemCell.reuseIdentifier, for: indexPath) as! ExhibitionCardItemCell
        let allItems = CardInfoItem.allCases[indexPath.row]
        let isSelected = CardInfoItem(rawValue: indexPath.row) == currentSelectedItem
        cell.configure(title: allItems.title, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chooseItem?(CardInfoItem(rawValue: indexPath.row)!)
        currentSelectedItem = CardInfoItem(rawValue: indexPath.row)!
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 16 * 5) / 5
        let cellHeight = 48.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
