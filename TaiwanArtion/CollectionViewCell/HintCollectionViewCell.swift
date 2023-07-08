//
//  HintCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/8.
//

import UIKit

class HintCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HintCollectionViewCell"
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(hint: String) {
        hintLabel.text = hint
    }
}
