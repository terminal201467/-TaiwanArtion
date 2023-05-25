//
//  NewsContentTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/24.
//

import UIKit

class NewsContentTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "NewsContentTableViewCell"
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .grayTextColor
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
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureContent(text: String) {
        contentLabel.text = text
    }
}
