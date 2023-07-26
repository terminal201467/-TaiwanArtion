//
//  AllExhibitionSelectItemsView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

public enum Items: Int, CaseIterable {
    case newest = 0, popular, highRank, recent
    var text: String {
        switch self {
        case .newest: return "最新展覽"
        case .popular: return "人氣展覽"
        case .highRank: return "評分最高"
        case .recent: return "最近日期"
        }
    }
}

class SelectCollectionItemsView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = HomeViewModel.shared
    
    private let itemsObservable = Observable.just(Items.allCases)

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .whiteGrayColor
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewBinding()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewBinding() {
        viewModel.inputs.itemSelected.onNext([0,0])
        collectionView.rx.setDelegate(self)
        collectionView.rx.itemSelected
            .bind(to: viewModel.inputs.itemSelected)
            .disposed(by: disposeBag)
        
        viewModel.outputs.items
            .map { item in
                return Items.allCases.map{ $0 == item }
            }
            .bind(to: collectionView.rx.items(cellIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, cellType: SelectedItemsCollectionViewCell.self)) { row, isSelected, cell in
                cell.configure(with: Items.allCases[row].text, selected: isSelected)
            }
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        backgroundColor = .whiteGrayColor
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension SelectCollectionItemsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 16 * 2 - 10 * 3) / 4
        let cellHeight = 34.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
    }
}
