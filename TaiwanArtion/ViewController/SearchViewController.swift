//
//  SearchViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class SearchViewController: UIViewController {

    private let viewModel = SearchViewModel()
    
    private let searchView = SearchView()
    
    private var isSearchModeViewOn: Bool = false {
        didSet {
            self.searchView.filterContentCollectionView.reloadData()
            self.searchView.tableView.reloadData()
        }
    }
    
    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
        setSearchindModeChanged()
    }
    
    private func setTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    
    private func setCollectionView() {
        searchView.filterContentCollectionView.dataSource = self
        searchView.filterContentCollectionView.delegate = self
    }
    
    private func setSearchindModeChanged() {
        searchView.isBeginSearchMode = { changed in
            self.viewModel.changedModeWith(isSearching: changed)
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewNumberOfRowInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellInfo = viewModel.collectionViewCellForRowAt(indexPath: indexPath)
        if isSearchModeViewOn {
            switch AlreadyFilter(rawValue: indexPath.row) {
            case .result:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .news:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .nearest:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .filterIcon:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
                cell.configure(iconText: cellInfo.title)
                return cell
            case .none: print("none")
            }
        } else {
            switch FilterType(rawValue: indexPath.row) {
            case .city:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .place:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .date:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .price:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchingCollectionViewCell
                cell.configure(title: cellInfo.title, isSelected: cellInfo.isSelected)
                return cell
            case .none: print("none")
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}