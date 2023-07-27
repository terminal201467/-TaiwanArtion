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

class CollectView: UIView {
    
    var changedSearchText: ((String) -> Void)?
    
    //MARK: -background
    private let leftImage: UIImageView = {
        let imageView = UIImageView(image: .init(named: "leftImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: -foreground
    
//    private let searchTextField: UITextField = {
//       let textField = UITextField()
//        textField.roundCorners(cornerRadius: 20)
//        textField.leftView = UIImageView(image: .init(named: "search"))
//        textField.backgroundColor = .white
//        textField.placeholder = "搜尋已收藏的展覽"
//        textField.tintColor = .grayTextColor
//        return textField
//    }()
    
    //Menu
    let menu = MenuCollectionView(frame: .infinite, menu: CollectMenu.allCases.map{$0.text})
    
    //ContentView
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.register(AllExhibitionCollectionViewCell.self, forCellWithReuseIdentifier: AllExhibitionCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return collectionView
    }()
    
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(36.0)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(menu.snp.bottom).offset(24.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
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

