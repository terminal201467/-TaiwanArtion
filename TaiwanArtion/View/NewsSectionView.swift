//
//  NewsSectionView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/25.
//

import UIKit
import SnapKit

class NewsSectionView: UITableViewHeaderFooterView {

    static let reuseIdentifier: String = "NewsSectionView"
    
    private let bar: UIView = {
        let view = UIView()
        view.backgroundColor = .brownColor
        view.roundCorners(cornerRadius: 2)
        return view
    }()
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .brownColor
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
        addSubview(bar)
        bar.snp.makeConstraints { make in
            make.width.equalTo(4)
            make.height.equalTo(22)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(sectionTitleLabel)
        sectionTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bar.snp.centerY)
            make.leading.equalTo(bar.snp.trailing).offset(4)
        }
    }
    
    func configure(title: String) {
        sectionTitleLabel.text = title
    }
    
}
