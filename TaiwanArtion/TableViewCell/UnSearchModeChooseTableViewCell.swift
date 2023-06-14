//
//  CityChooseTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/6.
//

import UIKit

class UnSearchModeChooseTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "UnSearchModeChooseTableViewCell"
    
    private var items: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var currentSelectedCells: Set<Int> = []
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
        }
    }
    
    func selectAllItem() {
        if currentSelectedCells.isEmpty {
//            currentSelectedCells.insert(items.map{$0.enumerated()}.)
        } else {
            currentSelectedCells.removeAll()
        }
    }
    
    func configure(itemTitle: [String]) {
        self.items = itemTitle
    }
}

extension UnSearchModeChooseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
        if currentSelectedCells.isEmpty {
            cell.configure(with: items[indexPath.row], selected: false)
        } else {
            let isSelected = currentSelectedCells.contains(indexPath.row)
            cell.configure(with: items[indexPath.row], selected: isSelected)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 16 * 6) / 5
        let cellHeight = 80.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentSelectedCells.isEmpty {
            self.currentSelectedCells.insert(indexPath.row)
        } else if currentSelectedCells.contains(indexPath.row) {
            //如果重複現在選的indexPath的話，就移除
            self.currentSelectedCells.remove(indexPath.row)
        } else if currentSelectedCells.contains(indexPath.row) != true {
            //如果沒有包含現在選的indexPath的話，就加入
            currentSelectedCells.insert(indexPath.row)
        } else {
            currentSelectedCells.insert(indexPath.row)
        }
        collectionView.reloadData()
    }
    
}
