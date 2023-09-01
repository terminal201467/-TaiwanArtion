//
//  PasswordHintTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import UIKit
import SnapKit

class PasswordHintTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "PasswordHintTableViewCell"
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let listLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImage, listLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 9
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
        contentView.backgroundColor = .white
        contentView.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureHintTitle(imageName: String ,listText: String) {
        logoImage.image = .init(named: imageName)
        listLabel.text = listText
        listLabel.font = .systemFont(ofSize: 14, weight: .heavy)
    }
    
    func configureList(listText: String, isThroughTest: Bool) {
        listLabel.text = listText
        listLabel.textColor = isThroughTest ? .brownColor : .whiteGrayColor
        logoImage.image = .init(named: isThroughTest ? "brownCheck" : "whiteGrayCheck")
        
    }
    
}
