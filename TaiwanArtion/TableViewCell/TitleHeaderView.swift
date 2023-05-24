//
//  TitleHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/22.
//

import UIKit

class TitleHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier: String = "TitleHeaderView"

    private let titleLabel: UILabel = {
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    func configureYear(with text: String) {
        titleLabel.text = "\(text)年"
    }
    
    func configureTitle(with text: String) {
        titleLabel.text = text
    }
}
