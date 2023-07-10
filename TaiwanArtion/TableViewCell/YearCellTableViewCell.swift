//
//  YearCellTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/10.
//

import UIKit

class YearCellTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "YearCellTableViewCell"
    
    let yearLabel: UILabel = {
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
        contentView.backgroundColor = .white
        contentView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(year: String, isSelected: Bool?) {
        yearLabel.text = year
        if isSelected == nil {
            yearLabel.textColor = .black
        } else {
            yearLabel.textColor = isSelected! ? .brownColor : .black
        }
    }
}
