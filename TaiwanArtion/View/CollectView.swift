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
    
    var changedSearchText: ((String) -> Void)?
    
    var currentTimeMenuSelected: Int = 0 {
        didSet {
            self.timeMenu.reloadData()
        }
    }
    
    var selectedTimeMenu: ((Int) -> Void)?
    
    //MARK: -background
    private let leftImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "leftImage"))
        imageView.contentMode = .scaleAspectFit
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
    
    //timeMenu
    let timeMenu: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return collectionView
    }()
    
    //contents
    let contents: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(AllExhibitionCollectionViewCell.self, forCellWithReuseIdentifier: AllExhibitionCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
        setTimeMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTimeMenu() {
        timeMenu.delegate = self
        timeMenu.dataSource = self
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
        
        containerView.addSubview(timeMenu)
        timeMenu.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalToSuperview().offset(16.0)
            make.height.equalTo(60.0)
        }
        
        containerView.addSubview(contents)
        contents.snp.makeConstraints { make in
            make.top.equalTo(timeMenu.snp.bottom)
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.bottom.equalToSuperview()
        }
    }
}

extension CollectView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        textField.becomeFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changedSearchText?(textField.text ?? "")
//        arrowButton.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension CollectView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TimeMenu.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
        let isSelected = currentTimeMenuSelected == indexPath.row
        cell.configure(with: TimeMenu.allCases[indexPath.row].text, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentTimeMenuSelected = indexPath.row
        selectedTimeMenu?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 88, height: 34.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

