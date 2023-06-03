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
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(bar)
        bar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(titleLabel.frame.width * 0.5)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(title: String, isSelected: Bool) {
        titleLabel.textColor = isSelected ? .brownTitleColor : .grayTextColor
        bar.backgroundColor = isSelected ? .brownTitleColor : nil
    }
}
