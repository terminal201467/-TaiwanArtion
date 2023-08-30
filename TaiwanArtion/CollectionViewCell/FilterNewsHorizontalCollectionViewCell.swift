//
//  FilterNewsHorizontalCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/30.
//

import UIKit

class FilterNewsHorizontalCollectionViewCell: UICollectionViewCell {
    
    var filterItem: ((NewsFilterItem) -> Void)?
    
    static let reuseIdentifier: String = "FilterNewsHorizontalCollectionViewCell"
    
    private var currentFilterItem: NewsFilterItem = .recentNews
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
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
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
extension FilterNewsHorizontalCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NewsFilterItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
        let isSelected = currentFilterItem == NewsFilterItem.allCases[indexPath.row]
        cell.configure(with: NewsFilterItem.allCases[indexPath.row].text, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentFilterItem = NewsFilterItem(rawValue: indexPath.row)!
        filterItem?(NewsFilterItem.allCases[indexPath.row])
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 5
        let cellHeight = 34.0
        return .init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 16, bottom: 8, right: 16)
    }
}
