//
//  MainPhotosTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import UIKit

class MainPhotosTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "MainPhotosTableViewCell"
    
    var mainPhotos: [ExhibitionModel] = []
    
    private let collectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MainPhotosCollectionViewCell.self, forCellWithReuseIdentifier: MainPhotosCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
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
        }
    }
}

extension MainPhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  mainPhotos.isEmpty ? 1 : mainPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPhotosCollectionViewCell.reuseIdentifier, for: indexPath) as! MainPhotosCollectionViewCell
        cell.configure(title: mainPhotos[indexPath.row].title,
                       date: mainPhotos[indexPath.row].date,
                       tagText: "雕塑",
                       image: mainPhotos[indexPath.row].image)
        cell.contentView.roundCorners(cornerRadius: 12)
        cell.contentView.applyShadow(color: .black, opacity: 0.5, offset: CGSize(width: 2, height: 2), radius: 4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //跳出細節頁面
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = frame.height
        let cellWidth = frame.width - 45 * 2
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
