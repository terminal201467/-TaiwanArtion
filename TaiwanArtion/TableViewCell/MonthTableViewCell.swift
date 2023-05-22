//
//  MonthTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/17.
//

import UIKit

enum Month: Int, CaseIterable {
    case jan = 0, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    var numberText: String {
        switch self {
        case .jan: return "1"
        case .feb: return "2"
        case .mar: return "3"
        case .apr: return "4"
        case .may: return "5"
        case .jun: return "6"
        case .jul: return "7"
        case .aug: return "8"
        case .sep: return "9"
        case .oct: return "10"
        case .nov: return "11"
        case .dec: return "12"
        }
    }
    
    var englishText: String {
        switch self {
        case .jan: return "Jan"
        case .feb: return "Feb"
        case .mar: return "Mar"
        case .apr: return "Apr"
        case .may: return "May"
        case .jun: return "Jun"
        case .jul: return "Jul"
        case .aug: return "Aug"
        case .sep: return "Sep"
        case .oct: return "Oct"
        case .nov: return "Nov"
        case .dec: return "Dec"
        }
    }
}

class MonthTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "HabbyTableViewCell"
    
    private let collectionView: UICollectionView = {
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
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MonthTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Month.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.reuseIdentifier, for: indexPath) as! MonthCollectionViewCell
        cell.configureLabel(month: Month.allCases[indexPath.row], selected: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.reuseIdentifier, for: indexPath) as! MonthCollectionViewCell
        cell.configureLabel(month: Month.allCases[indexPath.row], selected: true)
        //點按之後，回傳到HomeViewController中
        collectionView.reloadData()
    }
}
