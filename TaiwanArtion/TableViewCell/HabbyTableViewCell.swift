//
//  HabbyTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class HabbyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "HabbyTableViewCell"
    
    private let viewModel = HomeViewModel.shared
    
    private let habbyItemsObservable = Observable.just(HabbyItem.allCases)
    
    private let disposeBag = DisposeBag()
    
    private let collectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HabbyCollectionViewCell.self, forCellWithReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCollectionViewBinding()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewBinding() {
        collectionView.rx.setDelegate(self)
        collectionView.rx.itemSelected
            .bind(to: viewModel.inputs.habbySelected)
            .disposed(by: disposeBag)
        
        viewModel.outputs.habbys
            .map { item in
                return HabbyItem.allCases.map{ $0 == item }
            }
            .bind(to: collectionView.rx.items(cellIdentifier: HabbyCollectionViewCell.reuseIdentifier, cellType: HabbyCollectionViewCell.self)) { row, isSelected, cell in
                cell.configureHabby(by: HabbyItem.allCases[row], isSelected: isSelected)
            }
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .white
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

extension HabbyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 20 * 4) / 5
        let cellHeight = (frame.height - 20) / 2
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
}
