//
//  ExhibitionCalendarView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/30.
//

import UIKit

class ExhibitionCalendarView: UIView {
    
    var calendarContentMode: CalendarTypeChooseItem = .exhibitionCalendar {
        didSet {
            //重新ReloadCollectionView、TableView
            habbyCollectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    //MARK: - NavigationBar
    
//    let navigationBarContainerView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
//    private lazy var calendarButton: UIButton = {
//        let button = UIButton()
//        button.setImage(.init(named: calendarContentMode == .exhibitionCalendar ? "barCalendar" : "barCalendarSelected"), for: .normal)
//        button.addTarget(self, action: #selector(selectedCalendar), for: .touchDown)
//        return button
//    }()
//
//    private lazy var listButton:  UIButton = {
//        let button = UIButton()
//        button.setImage(.init(named: calendarContentMode == .exhibitionList ? "barList" : "barListSelected"), for: .normal)
//        button.addTarget(self, action: #selector(selectedList), for: .touchDown)
//        return button
//    }()
    
    
    private let barButtonContainerView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 20)
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: -Background
    private let leftBackgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "CalendarPageBackgroundWave")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rightTopImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "CalendarPageRightTopWave")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: -Foreground

    let habbyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HabbyCollectionViewCell.self, forCellWithReuseIdentifier: HabbyCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let habbyContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let contentContainerview: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow(color: .black, opacity: 0.3, offset: CGSize(width: 1, height: 1), radius: 4)
        return view
    }()
    
    private let calendarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let tableContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: -Contents
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(NotifyTableViewCell.self, forCellReuseIdentifier: NotifyTableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.applyShadow(color: .black, opacity: 0.3, offset: CGSize(width: 1, height: 1), radius: 4)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundAutoLayout()
        setGestureInTableContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBackgroundAutoLayout() {
        backgroundColor = .caramelColor
        
        addSubview(rightTopImage)
        rightTopImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        addSubview(habbyContainerView)
        habbyContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24.0)
            make.height.equalTo(78.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(contentContainerview)
        contentContainerview.snp.makeConstraints { make in
            make.top.equalTo(habbyContainerView.snp.bottom).offset(16.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        habbyContainerView.addSubview(habbyCollectionView)
        habbyCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    //MARK: ModeTransitionMethod
    private func setCalendarModeAutoLayout() {
        contentContainerview.addSubview(calendarContainerView)
        calendarContainerView.snp.makeConstraints { make in
            make.top.equalTo(habbyContainerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(452.0)
        }
        
        contentContainerview.addSubview(tableContainerView)
        tableContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(calendarContainerView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setListModeContainerAutoLayout() {
        contentContainerview.addSubview(tableContainerView)
        tableContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setGestureInTableContainer() {
        let upGesture = UISwipeGestureRecognizer(target: tableContainerView, action: #selector(upSwipe))
        upGesture.direction = .up
        tableContainerView.addGestureRecognizer(upGesture)
        
        let downGesture = UISwipeGestureRecognizer(target: tableContainerView, action: #selector(downSwipe))
        downGesture.direction = .down
        tableContainerView.addGestureRecognizer(upGesture)
    }
    
    @objc private func upSwipe() {
        UIView.animate(withDuration: 0.3) {
            self.tableContainerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    @objc private func downSwipe() {
        UIView.animate(withDuration: 0.3) {
            self.tableContainerView.snp.makeConstraints { make in
                make.top.equalTo(self.calendarContainerView.snp.bottom)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalTo(self.contentContainerview.snp.bottom)
            }
        }
    }
    
    @objc private func selectedCalendar() {
        calendarContentMode = .exhibitionCalendar
    }
    
    @objc private func selectedList() {
        calendarContentMode = .exhibitionList
    }
}
