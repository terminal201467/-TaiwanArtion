//
//  ExhibitionCollectionView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/7.
//

import UIKit

class ExhibitionCollectionView: UIView {

    var currentTimeMenuSelected: Int = 0 {
        didSet {
            self.timeMenu.reloadData()
        }
    }
    
    var selectedTimeMenu: ((Int) -> Void)?
    
    //timeMenu
    let timeMenu: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return collectionView
    }()
    
    //contents
    let contents: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AllExhibitionCollectionViewCell.self, forCellWithReuseIdentifier: AllExhibitionCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTimeMenu()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTimeMenu() {
        timeMenu.delegate = self
        timeMenu.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(timeMenu)
        timeMenu.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalToSuperview().offset(16.0)
            make.height.equalTo(60.0)
        }
        
        addSubview(contents)
        contents.snp.makeConstraints { make in
            make.top.equalTo(timeMenu.snp.bottom)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview()
        }
    }
}

extension ExhibitionCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TimeMenu.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
        let isSelected = currentTimeMenuSelected == indexPath.row
        cell.configure(with: TimeMenu.allCases[indexPath.row].text, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentTimeMenuSelected = indexPath.row
        selectedTimeMenu?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 88, height: 34.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
