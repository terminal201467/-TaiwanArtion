//
//  HotDetailTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import UIKit

class HotDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "HotDetailTableViewCell"
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "near"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var dateAndLoacationStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, locationIcon, cityLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 4.67
        return stackView
    }()
    
    //detail info
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var detailStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateAndLoacationStack])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    
    //number + Image
    private let exhibitionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: 8)
        return imageView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .brownTitleColor
        return label
    }()
    
    private lazy var hotDetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberLabel, exhibitionImage, detailStack])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
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
        addSubview(hotDetailStackView)
        hotDetailStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(title: String, location: String, date: String, image: String) {
        titleLabel.text = title
        cityLabel.text = location
        dateLabel.text = date
        exhibitionImage.image = UIImage(named: image)
    }
}
