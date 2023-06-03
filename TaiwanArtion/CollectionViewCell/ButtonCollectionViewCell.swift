//
//  ButtonCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/3.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ButtonCollectionViewCell"
    
    var action: (() -> Void)?
    
    let button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectAction), for: .touchDown)
        return button
    }()
    
    @objc private func selectAction() {
        action?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(iconText: String) {
        button.setImage(UIImage(named: iconText), for: .normal)
    }
}
