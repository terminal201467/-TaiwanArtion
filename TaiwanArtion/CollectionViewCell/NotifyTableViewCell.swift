//
//  NotifyTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/1.
//

import UIKit

class NotifyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "NotifyTableViewCell"

    private let exhibitionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: 8)
        return imageView
    }()
    
    private let redDotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "redDot")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .tagYellowColor
        label.textAlignment = .center
        label.setSpecificRoundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner], radius: 8)
        return label
    }()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "near")
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let beforeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var dateLocationStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, iconImage, locationLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLocationStack])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
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
        contentView.backgroundColor = .whiteGrayColor
        contentView.roundCorners(cornerRadius: 20)
        contentView.addSubview(exhibitionImage)
        contentView.addSubview(infoStack)
        contentView.addSubview(beforeLabel)
        contentView.addSubview(redDotImage)
        
        exhibitionImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(125.0 / frame.width)
            make.height.equalToSuperview().multipliedBy(80.0 / frame.height)
        }
        
        redDotImage.snp.makeConstraints { make in
            make.centerY.equalTo(exhibitionImage.snp.top)
            make.centerX.equalTo(exhibitionImage.snp.leading)
            make.width.equalTo(8.0)
            make.height.equalTo(8.0)
        }
        
        infoStack.snp.makeConstraints { make in
            make.leading.equalTo(exhibitionImage.snp.trailing).offset(16)
            make.top.equalTo(exhibitionImage.snp.top)
            make.bottom.equalTo(exhibitionImage.snp.bottom)
            make.trailing.equalToSuperview()
        }
        
        beforeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        exhibitionImage.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(exhibitionImage.snp.leading)
            make.bottom.equalTo(exhibitionImage.snp.bottom)
            make.height.equalToSuperview().multipliedBy(24.0 / frame.height)
            make.width.equalToSuperview().multipliedBy(40.0 / frame.width)
        }
    }
    
    func configure(title: String, date: String, location: String, dayBefore: String, tag: String) {
        titleLabel.text = title
        dateLabel.text = date
        locationLabel.text = location
        beforeLabel.text = dayBefore
        tagLabel.text = tag
    }
    
    func isRead(isOn: Bool) {
        redDotImage.isHidden = isOn
    }
}
