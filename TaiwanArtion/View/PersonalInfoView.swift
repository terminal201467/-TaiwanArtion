//
//  PersonalInfoView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class PersonalInfoView: UIView, UIScrollViewDelegate {
    
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(InputTextFieldTableViewCell.self, forCellReuseIdentifier: InputTextFieldTableViewCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableViewBinding() {
        tableView.rx.setDelegate(self)
        
        //
        
        //
        
        
    }
    
    private func autoLayout() {
        addSubview(tableView)
        
    }

}
