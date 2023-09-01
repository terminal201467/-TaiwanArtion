//
//  HintTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit

class HintTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "HintTableViewCell"
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.backgroundColor = .white
        contentView.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func configure(hintText: String) {
        hintLabel.text = hintText
    }
}
