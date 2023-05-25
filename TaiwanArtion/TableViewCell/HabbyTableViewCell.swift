//
//  HabbyTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/17.
//

import UIKit

class HabbyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "HabbyTableViewCell"
    
    private let viewModel = HomeViewModel.shared
    
    private let collectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HabbyCollectionViewCell.self, forCellWithReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = true
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setColletionView()
        autoLayout()
    }
    
    private func setColletionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

extension HabbyTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabbyItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier, for: indexPath) as! HabbyCollectionViewCell
        cell.configureHabby(by: viewModel.habbyCellForRowAt(indexPath: indexPath).selectedHabby,
                            isSelected: viewModel.habbyCellForRowAt(indexPath: indexPath).isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectHabbyItemAt(indexPath: indexPath)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 20 * 4) / 5
        let cellHeight = (frame.height - 20) / 2
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
}
