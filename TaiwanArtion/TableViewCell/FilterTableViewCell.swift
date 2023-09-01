//
//  FilterTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/26.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "FilterTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
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
        backgroundColor = .white
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(text: String) {
        label.text = text
    }
}
