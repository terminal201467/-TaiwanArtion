//
//  TitleMonthCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit

class TitleMonthCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "TitleMonthCollectionViewCell"
    
    private var currentTitleMonth: String = ""
    
    var nextMonthAction: (() -> Void)?
    
    var preMonthAction: (() -> Void)?
    
    private lazy var monthTitleBar: UIToolbar = {
        let rightArrowButton = UIBarButtonItem(image: .init(named: "rightArrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(nextMonth))
        let titleBarItem = UIBarButtonItem(title: self.currentTitleMonth, style: .plain, target: self, action: nil)
        titleBarItem.tintColor = .brownTitleColor
        let leftArrowButton = UIBarButtonItem(image: .init(named: "leftArrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(preMonth))
        let toolBar = UIToolbar()
        toolBar.barTintColor = .white
        toolBar.backgroundColor = .white
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolBar.items = [leftArrowButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), titleBarItem, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), rightArrowButton]
        return toolBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextMonth() {
        nextMonthAction?()
    }
    
    @objc private func preMonth() {
        preMonthAction?()
    }
    
    private func autoLayout() {
        addSubview(monthTitleBar)
        monthTitleBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(currenMonth: String) {
        currentTitleMonth = currenMonth
    }
}
