//
//  AllCommentHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit

class AllCommentHeaderView: UIView {
    
    var averageScore: Int = 0

    private let containerBrownView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 10)
        view.backgroundColor = .brownColor
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let starCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(StarCollectionViewCell.self, forCellWithReuseIdentifier: StarCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var commentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [commentCountOrNameLabel, starCollectionView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [containerBrownView, commentStack])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
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
        starCollectionView.delegate = self
        starCollectionView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureAllComment(number: Int, commentCount: Int, starScore: Int) {
        numberLabel.text = "\(number)"
        commentCountLabel.text = "\(commentCount)則評論"
        self.starScore = starScore
    }

}

extension AllCommentHeaderView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCollectionViewCell.reuseIdentifier, for: indexPath) as! StarCollectionViewCell
        cell.configure(isValueStar: averageScore == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 10.0
        let cellHeight = 10.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
}
