//
//  CollectionView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/26.
//

import UIKit
import SnapKit
import RxSwift

enum CollectMenu: Int, CaseIterable {
    case collectExhibition = 0, collectExhibitionHall, collectNews
    var text: String {
        switch self {
        case .collectExhibition: return "收藏展覽"
        case .collectExhibitionHall: return "收藏展覽館"
        case .collectNews: return "收藏新聞"
        }
    }
}

enum TimeMenu: Int, CaseIterable {
    case allExhibition = 0, todayStart, tomorrowStart, weekStart
    var text: String {
        switch self {
        case .allExhibition: return "全部"
        case .todayStart: return "今天開始"
        case .tomorrowStart: return "明天開始"
        case .weekStart: return "本週開始"
        }
    }
}

class CollectView: UIView {
    
    //MARK: -background
    private let leftImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "leftImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: 20)
        return imageView
    }()
    
    //MARK: -foreground
    //Menu
    let menu = MenuCollectionView(frame: .infinite, menu: CollectMenu.allCases.map{$0.text})
    
    //ContentView
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        view.applyShadow(color: .black, opacity: 0.3, offset: CGSize(width: 1.0, height: 1.0), radius: 4)
        return view
    }()
    
    let exhibitionCollectionView = ExhibitionCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func backgroundAutoLayout() {
        backgroundColor = .caramelColor
        addSubview(leftImage)
        leftImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func foregroundAutoLayout() {
        addSubview(menu)
        menu.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(36.0)
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(menu.snp.bottom).offset(24.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        containerView.addSubview(exhibitionCollectionView)
        exhibitionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

