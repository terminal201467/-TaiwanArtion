//
//  LoginView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    //MARK: -BackgroundView
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "loginBackgroundImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: -ForegroundView
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.register(NotMemberTableViewCell.self, forCellReuseIdentifier: NotMemberTableViewCell.reuseIdentifier)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
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
        self.backgroundColor = .caramelColor
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

