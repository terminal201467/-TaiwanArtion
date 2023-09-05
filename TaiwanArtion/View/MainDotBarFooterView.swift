//
//  MainDotBarFooterView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/23.
//

import UIKit
import RxSwift
import SnapKit

class MainDotBarFooterView: UIView {
    
    var isCurrentDot: ((Int) -> Void)?
    
    static let reuseIdentifier: String = "MainDotBarFooterView"
    
    private var storeItemCount: Int = 5
    
    private var currentIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MainDotCollectionViewCell.self, forCellWithReuseIdentifier: MainDotCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewDelegate()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setCollectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureIndex(currentIndex: Int) {
        self.currentIndex = currentIndex
    }
    
    func configureItemNumber(storeItemNumber: Int) {
        self.storeItemCount = storeItemNumber
    }
}

extension MainDotBarFooterView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainDotCollectionViewCell.reuseIdentifier, for: indexPath) as! MainDotCollectionViewCell
        var isCurrent = currentIndex == indexPath.row
        cell.configure(isCurrentDot: isCurrent)
        //如果是當前的index，就變成點點
        //如果不是，就變成灰長的view
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.isCurrentDot?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let largeCellWidth = 20.0
        let littleCellWidth = 8.0
        let cellHeight = collectionView.frame.height
        return  self.currentIndex == indexPath.row ? .init(width: littleCellWidth, height: cellHeight) : .init(width: largeCellWidth, height: cellHeight)
    }
}
