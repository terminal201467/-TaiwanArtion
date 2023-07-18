//
//  AlreadyLoginView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/17.
//

import UIKit

class AlreadyLoginView: UIView {
    
    //MARK: -Background
    private let lineImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "alreadyLine"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let middleBackgroundImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "middleBackgroundImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: -Foreground
    private let headPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alreadyLoginHead")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi! 吳偉熊"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner ,.layerMaxXMinYCorner], radius: 20)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(headImage: String, name: String) {
        headPhoto.image = UIImage(named: headImage)
        personNameLabel.text = name
    }
    
    private func backgroundAutoLayout() {
        addSubview(lineImage)
        lineImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        addSubview(middleBackgroundImage)
        middleBackgroundImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        backgroundColor = .caramelColor
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(207)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func foregroundAutoLayout() {
        containerView.addSubview(headPhoto)
        headPhoto.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(120.0)
            make.width.equalTo(120.0)
        }
        
        containerView.addSubview(personNameLabel)
        personNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headPhoto.snp.bottom).offset(8)
        }
    }
}
