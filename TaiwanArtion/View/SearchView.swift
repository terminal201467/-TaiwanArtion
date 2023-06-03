//
//  SearchView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchView: UIView {
    
    var backAction: (() -> Void)?
    
    var searchValueChanged: ((String) -> Void)?
    
    var isBeginSearchMode: ((Bool) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Background
    
    private let leftMiddleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "leftMiddleBackground")
        return imageView
    }()
    
    private lazy var searchBarStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, searchBar])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.barTintColor = .white
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.searchTextField.placeholder = "搜尋展覽"
        searchBar.roundCorners(cornerRadius: 20)
        return searchBar
    }()
    
    let filterContentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchingCollectionViewCell.self, forCellWithReuseIdentifier: SearchingCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var searchItemsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBarStack, filterContentCollectionView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    //MARK: - Foreground
    private lazy var searchStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBarStack, filterContentCollectionView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HotHintTableViewCell.self, forCellReuseIdentifier: <#T##String#>)
        tableView.allowsSelection = false
        tableView.isScrollEnabled = true
        tableView.setSpecificRoundCorners(corners: <#T##CACornerMask#>, radius: <#T##CGFloat#>)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        setTableView()
        setBackButton()
        setSearchBarBinding()
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackButton() {
        backButton.rx.tap
            .subscribe(onNext: {
                self.backAction?()
            })
            .disposed(by: disposeBag)
    }
    
    private func setSearchBarBinding() {
        searchBar.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] searchText in
                print("searchValueChanged:\(searchText)")
                self?.searchValueChanged?(searchText)
                self?.isBeginSearchMode?(true)
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - AutoLayout
    private func backgroundAutoLayout() {
        backgroundColor = .caramelColor
        addSubview(leftMiddleImage)
        leftMiddleImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(150.0)
        }
    }
    
    private func foregroundAutoLayout() {
        backButton.snp.makeConstraints { make in
            make.height.equalTo(36.0)
            make.width.equalTo(36.0)
        }
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(36.0)
            make.width.equalToSuperview().multipliedBy(298.0 / frame.width)
        }
        
        addSubview(searchItemsStack)
        searchItemsStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(200.0)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(searchItemsStack.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
}
