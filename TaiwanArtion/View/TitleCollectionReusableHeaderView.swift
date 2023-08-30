//
//  TitleCollectionReusableHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/29.
//

import UIKit

class TitleCollectionReusableHeaderView: UICollectionReusableView {
        
    static let reuseIdentifier: String = "Header"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .blackDarkGrayColor
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
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(text: String, textSize: CGFloat) {
        label.text = text
        label.font = .systemFont(ofSize: textSize, weight: .bold)
    }
}
