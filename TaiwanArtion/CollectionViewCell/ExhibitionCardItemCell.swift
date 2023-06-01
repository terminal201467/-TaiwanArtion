//
//  ExhibitionCardItemCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/25.
//

import UIKit

class ExhibitionCardItemCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ExhibitionCardItemCell"

    let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        return label
    }()
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .brownColor
        view.roundCorners(cornerRadius: 2)
        view.isHidden = true
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
        addSubview(itemTitleLabel)
        itemTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(barView)
        barView.snp.makeConstraints { make in
            make.top.equalTo(itemTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(itemTitleLabel.snp.leading)
            make.trailing.equalTo(itemTitleLabel.snp.trailing)
            make.height.equalTo(2)
            make.width.equalTo(itemTitleLabel.snp.width)
        }
    }
    
    func configure(title: String, selected: Bool) {
        itemTitleLabel.text = title
        selected ? selectedItem() : notSelectedItem()
    }
    
    private func selectedItem() {
        itemTitleLabel.textColor = .brownColor
        barView.isHidden = false
    }
    
    private func notSelectedItem() {
        itemTitleLabel.textColor = .grayTextColor
        barView.isHidden = true
    }
}
