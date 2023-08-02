//
//  ExhibitionHallView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/2.
//

import UIKit

enum ExhibitionHallMenu: Int, CaseIterable {
    case overviewExhibition = 0, recentExhibition, soonOpenExhibition, finishExhibition
    var text: String {
        switch self {
        case .overviewExhibition: return "展覽館總覽"
        case .recentExhibition: return "近期展覽"
        case .soonOpenExhibition: return "即將展覽"
        case .finishExhibition: return "結束展覽"
        }
    }
}

enum ExhibitionHallContent: Int, CaseIterable {
    case time = 0, telephone, website, address
    var text: String {
        switch self {
        case .time: return "營業時間"
        case .telephone: return "展覽電話"
        case .website: return "展覽官網"
        case .address: return "地址"
        }
    }
}

class ExhibitionHallView: UIView {
    //MARK: -Background
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setSpecificRoundCorners(corners: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 12)
        return imageView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: -Foreground
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.roundCorners(cornerRadius: 20)
        searchBar.backgroundColor = .white
        searchBar.searchTextField.placeholder = "輸入展覽名稱"
        searchBar.searchTextField.tintColor = .grayTextColor
        searchBar.searchTextField.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        return searchBar
    }()
    
    private let menu = MenuCollectionView(frame: .zero, menu: ExhibitionHallMenu.allCases.map{$0.text})
    
    private let tableView: UITableView = {
        let tableView = UITableView()
//        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        tableView.allowsSelection = false
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(242.0 / frame.height)
        }
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImage.snp.bottom)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        addSubview(menu)
        menu.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24.0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(34.0)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(menu.snp.bottom).offset(40)
            make.leading.equalTo(menu.snp.leading)
            make.trailing.equalTo(menu.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension ExhibitionHallView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExhibitionHallContent.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ExhibitionHallContent(rawValue: indexPath.row) {
        case .time:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailTableViewCell.reuseIdentifier, for: indexPath) as! NewsDetailTableViewCell
            return cell
        case .telephone:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailTableViewCell.reuseIdentifier, for: indexPath) as! NewsDetailTableViewCell
            return cell
        case .website:
            print("")
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailTableViewCell.reuseIdentifier, for: indexPath) as! NewsDetailTableViewCell
            return cell
        case .none:
            print("none")
        }
        return UITableViewCell()
    }
    
}
