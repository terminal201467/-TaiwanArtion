//
//  SelectedItemsCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/24.
//

import UIKit

class SelectedItemsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "SelectedItemsCollectionViewCell"
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let backgroundChangedView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 12)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(backgroundChangedView)
        backgroundChangedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.greaterThanOrEqualToSuperview()
        }
        
        backgroundChangedView.addSubview(itemLabel)
        itemLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualToSuperview()
        }
    }
    
    func configure(with text: String, selected: Bool) {
        if selected {
            itemLabel.text = text
            backgroundChangedView.backgroundColor = .brownTitleColor
            itemLabel.textColor = .white
        } else {
            itemLabel.text = text
            backgroundChangedView.backgroundColor = .whiteGrayColor
            itemLabel.textColor = .grayTextColor
        }
    }
}
