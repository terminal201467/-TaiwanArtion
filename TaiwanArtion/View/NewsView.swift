//
//  NewsView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class NewsView: UIView {

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
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
    
    private let contentView: UIView = {
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
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let tabView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let collectButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "collect"), for: .normal)
        button.setTitleColor(.grayTextColor, for: .normal)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        button.setTitleColor(.grayTextColor, for: .normal)
        return button
    }()
    
    let calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar"), for: .normal)
        button.setTitleColor(.grayTextColor, for: .normal)
        return button
    }()
    
    private let shareLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .grayTextColor
        label.text = "分享展覽"
        label.textAlignment = .center
        return label
    }()
    
    private let collectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .grayTextColor
        label.text = "收藏展覽"
        label.textAlignment = .center
        return label
    }()
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .grayTextColor
        label.text = "加入日曆"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [collectButton, collectLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var shareStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shareButton, shareLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var calendarStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calendarButton, calendarLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var tabs: [UIView] = [collectStack, shareStack]
    
    private lazy var tabStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
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
        
        addSubview(tabView)
        tabView.snp.makeConstraints { make in
            make.height.equalTo(80.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tabView.addSubview(tabStack)
        tabStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(41.0)
        }
    }
    
    func configure(title: String, backgroundImageText: String) {
        titleLabel.text = title
        backgroundImage.image = UIImage(named: backgroundImageText)
    }
}
