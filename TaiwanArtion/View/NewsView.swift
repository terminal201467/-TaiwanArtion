//
//  NewsView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/24.
//

import UIKit

class NewsView: UIView {

    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setSpecificRoundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 20)
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NewsDetailTableViewCell.self, forCellReuseIdentifier: NewsDetailTableViewCell.reuseIdentifier)
        tableView.register(NewsContentTableViewCell.self, forCellReuseIdentifier: NewsContentTableViewCell.reuseIdentifier)
        tableView.register(NewsSectionView.self, forHeaderFooterViewReuseIdentifier: NewsSectionView.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.equalTo(36.0)
            make.height.equalTo(36.0)
            make.leading.equalToSuperview().offset(16.0)
            make.top.equalToSuperview().offset(60.0)
        }
    }
    
    func configure(title: String, backgroundImageText: String) {
        titleLabel.text = title
        backgroundImage.image = UIImage(named: backgroundImageText)
    }
}
