//
//  NearView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MapKit

enum NearViewSelectedItem: Int, CaseIterable {
    case nearExhibitionHall = 0, nearExhibition
    var text: String {
        switch self {
        case .nearExhibitionHall: return "附近展覽館"
        case .nearExhibition: return "附近展覽"
        }
    }
}

class NearView: UIView {
    
    private let disposeBag = DisposeBag()
    
    let filterSubject: PublishSubject<Void> = PublishSubject()
    
    var locatedNearSignal: Signal<Void> = Signal.just(())
    
    var isHadSearchResult: Bool = true {
        didSet {
            setContainerLayout()
        }
    }
    
    var currentIndex: ((Int) -> Void)?
    
    private var currentStoreIndex: Int = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var searchText: String = ""
    
    var filterButtonIsSelected: Bool = false {
        didSet {
            setFilterButton()
        }
    }
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SelectedItemsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let menuBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let locateRecentExhibitionButton: UIButton = {
        let button = UIButton()
        button.setTitle("離我最近的展覽館", for: .normal)
        button.backgroundColor = .brownColor
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.roundCorners(cornerRadius: 12)
        return button
    }()
    
    let locationContentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LocationContentCollectionViewCell.self, forCellWithReuseIdentifier: LocationContentCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    private let containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let nothingSearchedView = ExhibitionNothingSearchedView(frame: .zero, type: .nothingFoundInNear)
    
    let mapView: MKMapView = {
       let mapView = MKMapView()
        return mapView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        setButtonSubscription()
        setFilterButton()
        autoLayout()
        setNothingSearch()
        setContainerLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNothingSearch() {
        nothingSearchedView.keyword = searchText
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setButtonSubscription() {
        filterButton.rx.tap
            .subscribe(onNext: {
                self.filterButtonIsSelected.toggle()
                self.filterSubject.onNext(())
            })
            .disposed(by: disposeBag)
        
        locatedNearSignal = locateRecentExhibitionButton.rx.tap
            .asSignal(onErrorJustReturn: ())
    }
    
    private func setFilterButton() {
        filterButton.setImage(.init(named: filterButtonIsSelected ? "selectedFilter" : "filter"), for: .normal)
    }
    
    private func autoLayout() {
        addSubview(menuBarView)
        menuBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(68.0)
        }
        
        menuBarView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        menuBarView.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(36.0)
            make.width.equalTo(36.0)
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(menuBarView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setContainerLayout() {
        containerView.removeAllSubviews(from: containerView)
        if isHadSearchResult {
            containerView.addSubview(mapView)
            mapView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            mapView.addSubview(locateRecentExhibitionButton)
            locateRecentExhibitionButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(24)
                make.width.equalToSuperview().dividedBy(3)
            }
            mapView.addSubview(locationContentCollectionView)
            locationContentCollectionView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(93.0 / mapView.frame.height)
            }
        } else {
            containerView.addSubview(nothingSearchedView)
            nothingSearchedView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

//MARK: -CollectionView Methods
extension NearView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NearViewSelectedItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectedItemsCollectionViewCell
        let isSelected = currentStoreIndex == indexPath.row
        cell.configure(with: NearViewSelectedItem.allCases[indexPath.row].text, selected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentStoreIndex = indexPath.row
        currentIndex?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 24, bottom: 16, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (collectionView.frame.width - 24 * 2 - 16) / 2
        let cellHeight = 34.0
        return .init(width: cellwidth, height: cellHeight)
    }
}
