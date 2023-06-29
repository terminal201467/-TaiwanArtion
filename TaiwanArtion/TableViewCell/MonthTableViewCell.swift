//
//  MonthTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay


class MonthTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "MonthTableViewCell"
    
    private let viewModel = HomeViewModel.shared
    
    private let disposeBag = DisposeBag()
    
    private let collectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setColletionView()
        autoLayout()
    }
    
    private func setCollectionViewBinding() {
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        //輸入進CollectionView
        collectionView.rx.itemSelected
            .bind(to: viewModel.inputs.monthSelected)
            .disposed(by: disposeBag)
        
        //輸出到CollectionView
        viewModel.didSelectedMonthRow
            .subscribe(onNext: { month in
                self.viewModel.fetchDateKind(by: month)
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.months
            .map { month in
                return Month.allCases.map { $0 == month }
            }
            .bind(to: collectionView.rx.items(cellIdentifier: MonthCollectionViewCell.reuseIdentifier, cellType: MonthCollectionViewCell.self)) { row, isSelected, cell in
                let month = Month.allCases[row]
                cell.configureLabel(month: month, selected: isSelected)
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .white
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension MonthTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 43)
    }
}
