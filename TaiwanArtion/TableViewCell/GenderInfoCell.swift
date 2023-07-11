//
//  GenderInfoCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/11.
//

import UIKit

class GenderInfoCell: UITableViewCell {
    
    static let reuseIdentifier: String = "GenderInfoCell"

    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(info: String, isSelected: Bool) {
        infoLabel.text = info
        infoLabel.textColor = isSelected ? .brownColor : .black
    }
}
