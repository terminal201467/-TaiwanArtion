//
//  FlexibleTabBarView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/26.
//

import UIKit

enum NewsTab: Int, CaseIterable {
    case collectNews = 0, shareNews
    var text: String {
        switch self {
        case .collectNews: return "收藏新聞"
        case .shareNews: return "分享新聞"
        }
    }
    
    var image: String {
        switch self {
        case .collectNews: return "collect"
        case .shareNews: return "share"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .collectNews: return "collectSelect"
        case .shareNews: return "shareSelect"
        }
    }
}

enum NearTab: Int, CaseIterable {
    case collectNews = 0, shareNews, addCalendar
    var text: String {
        switch self {
        case .collectNews: return "收藏新聞"
        case .shareNews: return "分享新聞"
        case .addCalendar: return "加入月曆"
        }
    }
    
    var image: String {
        switch self {
        case .collectNews: return "collect"
        case .shareNews: return "share"
        case .addCalendar: return "calendar"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .collectNews: return "collectSelect"
        case .shareNews: return "shareSelect"
        case .addCalendar: return "calendarSelected"
        }
    }
}

enum TabTypes: Int {
    case news = 0, near
}

class FlexibleTabBarView: UIView {
    
    var selectedTab: ((IndexPath) -> Void)?
    
    private var currentTab: IndexPath?
    
    private var tabTypes: TabTypes
    
    private var storeSelectedTab: Set<IndexPath> = []
    
    init(frame: CGRect, type: TabTypes) {
        self.tabTypes = type
        super.init(frame: frame)
        setCollectionView()
        autoLayout()
    }

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FlexibleTabBarCollectionViewCell.self, forCellWithReuseIdentifier: FlexibleTabBarCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FlexibleTabBarView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tabTypes {
        case .news: return NewsTab.allCases.count
        case .near: return NearTab.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlexibleTabBarCollectionViewCell.reuseIdentifier, for: indexPath) as! FlexibleTabBarCollectionViewCell
        let isExisted = storeSelectedTab.contains(indexPath)
        let newsTabs = NewsTab.allCases[indexPath.row]
        let nearTabs = NearTab.allCases[indexPath.row]
        switch tabTypes {
        case .news: cell.configure(image: newsTabs.image, selectedImage: newsTabs.selectedImage, text: newsTabs.text, isSelected: isExisted)
        case .near: cell.configure(image: nearTabs.image, selectedImage: nearTabs.selectedImage, text: nearTabs.text, isSelected: isExisted)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTab?(indexPath)
        if storeSelectedTab.contains(indexPath) {
            storeSelectedTab.remove(indexPath)
        } else {
            storeSelectedTab.insert(indexPath)
        }
    }
}
