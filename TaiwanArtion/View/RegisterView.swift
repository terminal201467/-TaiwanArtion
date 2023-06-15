//
//  RegisterView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

class RegisterView: UIView {
    
    //MARK: Background
    
    
    //MARK: Foreground
    let stepCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(RegisterStepCollectionViewCell.self, forCellWithReuseIdentifier: RegisterStepCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        
    }

}
