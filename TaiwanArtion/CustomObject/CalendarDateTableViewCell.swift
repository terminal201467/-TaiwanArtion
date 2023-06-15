//
//  CalendarDateTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit

class CalendarDateTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "CalendarDateTableViewCell"
    
    private let logicViewModel = CalendarLogic.shared
    
    private let dateCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.reuseIdentifier)
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
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
    }
    
    private func autoLayout() {
        contentView.addSubview(dateCollectionView)
        dateCollectionView.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension CalendarDateTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseIdentifier, for: indexPath) as! DateCollectionViewCell
        let cellInfo = logicViewModel.dateCellForRowAt(indexPath: indexPath)
        cell.configure(date: cellInfo.dateString,
                       isToday: cellInfo.isToday,
                       isCurrentMonth: cellInfo.isCurrentMonth)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 10 * 8) / 7
        let cellHeight = 40.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 2, bottom: 10, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        logicViewModel.dateDidSelectedRowAt(indexPath: indexPath)
    }
}
