//
//  ExhibitionCardItemCollectionView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit

enum EvaluationItems: Int, CaseIterable {
    case all = 0, newest, mostHigh, writeEvaluation
    var text: String {
        switch self {
        case .all: return "全部"
        case .newest: return "最新評價"
        case .mostHigh: return "最高評價"
        case .writeEvaluation: return "撰寫評價"
        }
    }
}

class ExhibitionCardItemCollectionView: UIView {
    
    var pushToViewController: (() -> Void)?
    
    static let reuseIdentifier: String = "ExhibitionCardItemCollectionView"
    
    private let viewModel = ExhibitionCardViewModel.shared
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = .whiteGrayColor
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ExhibitionCardItemCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Items.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
        let items = viewModel.itemCollectionViewCellForRowAt(indexPath: indexPath)
        cell.configure(with: items.item.text, selected: items.isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.itemCollectionViewDidSelectedTRowAt(indexPath: indexPath)
        collectionView.reloadData()
        if EvaluationItems(rawValue: indexPath.row) == .writeEvaluation {
            self.pushToViewController?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (frame.width - 10 * 3 - 16 * 2) / 4
        let cellHeight = 34.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
    }
    
}
