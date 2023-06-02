//
//  SystemTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit

class SystemTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "SystemTableViewCell"
    
    private let bellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bell")
        return imageView
    }()
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titlelabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private let beforeDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
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
        contentView.addSubview(bellImage)
        bellImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(40.0)
            make.height.equalTo(40.0)
        }
        
        contentView.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.leading.equalTo(bellImage.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(beforeDayLabel)
        beforeDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titlelabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
    
    func configure(title: String, description: String, dayBefore: Int) {
        titlelabel.text = title
        descriptionLabel.text = description
        beforeDayLabel.text = "\(dayBefore)天前"
        
    }
    
}
