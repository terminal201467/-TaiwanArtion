//
//  NearSearchResultView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/17.
//

import UIKit

class NearSearchResultView: UIView {
    
    private var historys: [String] = []

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.roundCorners(cornerRadius: 20)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.placeholder = "搜尋附近展覽"
        return searchBar
    }()
    
    private lazy var searchHistoryView = SearchingHistoryView(frame: .zero, historys: self.historys, type: .nothingFoundInNear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        backgroundColor = .caramelColor
        addSubview(searchHistoryView)
        searchHistoryView.applyShadow(color: .black, opacity: 0.3, offset: CGSize(width: 1, height: 1), radius: 4)
        searchHistoryView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(historys: [String]) {
        self.historys = historys
    }
}
