//
//  GenderTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit

class GenderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "GenderTableViewCell"

    private let containerView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 10)
        view.addBorder(borderWidth: 1, borderColor: .gray)
        return view
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let chooseButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "downArrow"), for: .normal)
        return button
    }()
    
    private lazy var genderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genderLabel, chooseButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(genderStack)
        genderStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(gender: String?) {
        genderLabel.text = gender == nil ? "請選擇你的性別" : gender
    }
}
