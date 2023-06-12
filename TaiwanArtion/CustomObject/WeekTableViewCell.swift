//
//  WeekTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit

class WeekTableViewCell: UITableViewCell {
    
    enum Week: Int, CaseIterable {
        case mon = 0, tue, wed, thu, fri, sat, sun
        var text: String {
            switch self {
            case .mon: return "一"
            case .tue: return "二"
            case .wed: return "三"
            case .thu: return "四"
            case .fri: return "五"
            case .sat: return "六"
            case .sun: return "日"
            }
        }
    }
    
    static let reuseIdentifier: String = "WeekTableViewCell"

    private let aWeek: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = false
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
        aWeek.delegate = self
        aWeek.dataSource = self
    }
    
    private func autoLayout() {
        contentView.addSubview(aWeek)
        aWeek.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension WeekTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Week.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.reuseIdentifier, for: indexPath) as! WeekCollectionViewCell
        cell.configure(title: Week.allCases[indexPath.row].text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 10 * 8) / 7
        let cellHeight = 18.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}
