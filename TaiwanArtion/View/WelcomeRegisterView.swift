//
//  WelcomeRegisterView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

enum RegisterButtons : Int, CaseIterable {
    case signIn = 0, register
}

class WelcomeRegisterView: UIView {
    
    var registerAction: (() -> (Void))?
    
    var loginAction: (() -> (Void))?
    
    var socialKitRegister: ((String) -> (Void))?

    //MARK: - BackgroundView
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "registerPageBackground")
        return imageView
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "registerLogoIcon")
        return imageView
    }()
    
    //MARK: - ForegroundView
    private let contentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        backgroundImage.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(contentTableView)
        contentTableView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.58)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension WelcomeRegisterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = WelcomeRegisterHeaderView()
        header.configure(titleText: "歡迎來到早找展覽", subTitleText: "開始探索下一段展覽之旅吧！")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = WelcomeRegisterFooterView()
        footer.facebookRegister = {
            self.socialKitRegister?("facebook")
        }
        
        footer.googleRegister = {
            self.socialKitRegister?("google")
        }
        
        footer.lineRegister = {
            self.socialKitRegister?("line")
        }
        return footer
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RegisterButtons.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
        switch RegisterButtons(rawValue: indexPath.row) {
        case .signIn:
            cell.configure(buttonname: "登入")
            cell.button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            cell.selectionStyle = .none
            cell.action = {
                self.loginAction?()
            }
        case .register:
            cell.configure(buttonname: "註冊")
            cell.button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            cell.button.hollowBrownRoundborder()
            cell.selectionStyle = .none
            cell.action = {
                self.registerAction?()
            }
        case .none:
            return UITableViewCell()
        }
        return cell
    }
}
