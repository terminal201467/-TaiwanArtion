//
//  NewsTableViewCell.swift
//  
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "NewsTableViewCell"
    
    private let viewModel = HomeViewModel.shared
    
    var pushToViewController: ((NewsModel) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let collectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
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
            .subscribe(onNext: { indexPath in
                self.viewModel.inputs.newsExhibitionSelected.onNext(indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.newsObservable
            .bind(to: collectionView.rx.items(cellIdentifier: NewsCollectionViewCell.reuseIdentifier, cellType: NewsCollectionViewCell.self)) { (row, item, cell) in
                cell.configure(image: item.image, title: item.title, date: item.date, author: item.author)
            }
            .disposed(by: disposeBag)
        
        viewModel.outputs.didSelectedNewsExhibitionRow
            .subscribe { news in
                self.pushToViewController?(news)
            }
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .white
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
