//
//  DateCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "DateCollectionViewCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(date: String, isToday: Bool) {
        dateLabel.text = date
//        dateLabel.textColor = isInMonth ? .black : .grayTextColor
        dateLabel.backgroundColor = isToday ? .brownColor : .white
    }
    
}
