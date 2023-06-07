//
//  SearchingCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/3.
//

import UIKit

class SearchingCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "SearchingCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let bar: UIView = {
        let view = UIView()
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.greaterThanOrEqualTo((frame.width - 16 * 6) / 5)
        }
        
        contentView.addSubview(bar)
        bar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(contentView.frame.width / 4.0)
        }
    }
    
    func configure(title: String, isSelected: Bool?) {
        titleLabel.text = title
        if isSelected == nil {
            titleLabel.textColor = .grayTextColor
            bar.backgroundColor = nil
        } else {
            titleLabel.textColor = isSelected! ? .brownTitleColor : .grayTextColor
            bar.backgroundColor = isSelected! ? .brownTitleColor : nil
        }
    }
}
