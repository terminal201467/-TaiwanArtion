//
//  ExhibitionHallView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/2.
//

import UIKit

enum ExhibitionHallMenu: Int, CaseIterable {
    case overviewExhibition = 0, recentExhibition, soonOpenExhibition, finishExhibition, allExhibition
    var text: String {
        switch self {
        case .overviewExhibition: return "展覽館總覽"
        case .recentExhibition: return "近期展覽"
        case .soonOpenExhibition: return "即將展覽"
        case .finishExhibition: return "結束展覽"
        case .allExhibition: return "全部展覽"
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
    
    private let locationImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "locationWhiteIcon"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let hallTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationImage, hallTitleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    let searchTextField: UISearchTextField = {
       let searchTextField = UISearchTextField()
        searchTextField.roundCorners(cornerRadius: 20)
        searchTextField.placeholder = "輸入展覽名稱"
        searchTextField.tintColor = .grayTextColor
        searchTextField.backgroundColor = .white
        searchTextField.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        searchTextField.keyboardType = .emailAddress
        return searchTextField
    }()
    
    let menu: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ExhibitionHallTableViewCell.self, forCellReuseIdentifier: ExhibitionHallTableViewCell.reuseIdentifier)
        tableView.register(NewsDetailTableViewCell.self, forCellReuseIdentifier: NewsDetailTableViewCell.reuseIdentifier)
        tableView.register(WebSiteTableViewCell.self, forCellReuseIdentifier: WebSiteTableViewCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
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
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(242.0)
        }
        
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundImage.snp.bottom)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.bottom.equalTo(searchTextField.snp.top).offset(16)
            make.leading.equalTo(searchTextField.snp.leading)
        }
        
        addSubview(menu)
        menu.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(24.0)
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
    
    func configure(hallTitle: String, hallImage: String?) {
        hallTitleLabel.text = hallTitle
        backgroundImage.image = UIImage(named: hallImage ?? "defaultBackgroundImage")
    }
}
