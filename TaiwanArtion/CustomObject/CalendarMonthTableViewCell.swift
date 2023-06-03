//
//  CalendarMonthTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit

class CalendarMonthTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "CalendarMonthTableViewCell"
    
    private let logicViewModel = CalendarLogic.shared
    
    private let monthCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.reuseIdentifier)
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
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
    }
    
    private func autoLayout() {
        contentView.addSubview(monthCollectionView)
        monthCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CalendarMonthTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Month.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.reuseIdentifier, for: indexPath) as! MonthCollectionViewCell
        let cellInfo = logicViewModel.monthCellForRowAt(indexPath: indexPath)
        cell.configureLabel(month: cellInfo.month, selected: cellInfo.isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 10 * 8) / 8
        let cellHeight = 43.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 2.5, left: 5, bottom: 2.5, right: 5)
    }
}
