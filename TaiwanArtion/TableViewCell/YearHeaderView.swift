//
//  YearHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/22.
//

import UIKit

class YearHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier: String = "YearHeaderView"

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func configure(with text: String) {
        yearLabel.text = "\(text)年"
    }
}
