//
//  ExhibitionCalendarView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/30.
//

import UIKit
import SnapKit

class ExhibitionCalendarView: UIView {
    
    var calendarMode: ((Bool) -> Void)?
    
    private var isCalendarMode: Bool = true {
        didSet {
            setNavigationBarSelected()
            habbyCollectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    //MARK: - NavigationBar
    
    let navigationBarContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "barCalendarSelected"), for: .normal)
        button.addTarget(self, action: #selector(selectedCalendar), for: .touchDown)
        return button
    }()

    private lazy var listButton:  UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "barList"), for: .normal)
        button.addTarget(self, action: #selector(selectedList), for: .touchDown)
        return button
    }()
    
    private lazy var navigationBarButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calendarButton, listButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
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
    
    private lazy var contentScrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = .gray
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: frame.width, height: 1000)
        return scrollView
    }()
    
    private let calendarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let tableContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return view
    }()
    
    //MARK: -Contents
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(NotifyTableViewCell.self, forCellReuseIdentifier: NotifyTableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.applyShadow(color: .black, opacity: 0.3, offset: CGSize(width: 1, height: 1), radius: 4)
        tableView.backgroundColor = .red
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNavigationBarAutoLayout()
        setBackgroundAutoLayout()
        setupGestures()
        setCalendarModeAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavigationBarAutoLayout() {
        addSubview(navigationBarContainerView)
        navigationBarContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(46.0)
        }
        
        navigationBarContainerView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16.0)
            make.width.equalTo(122.0)
            make.height.equalTo(46.0)
        }
        
        navigationBarContainerView.addSubview(navigationBarButtonStack)
        navigationBarButtonStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
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
            make.top.equalTo(navigationBarContainerView.snp.bottom).offset(24.0)
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
        contentContainerview.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentScrollView.addSubview(calendarContainerView)
        calendarContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(450.0)
            make.width.equalToSuperview()
        }

        contentScrollView.addSubview(tableContainerView)
        tableContainerView.snp.makeConstraints { make in
            make.top.equalTo(calendarContainerView.snp.bottom).offset(-40.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(600.0)
            make.bottom.equalToSuperview()
            tableTopConstraint = make.top.equalTo(calendarContainerView.snp.bottom).offset(-40.0).constraint
        }
    }
    
    private var tableTopConstraint: Constraint?
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        tableContainerView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: contentContainerview)
        
        if gestureRecognizer.state == .changed {
            let newConstant = min(max(tableTopConstraint!.layoutConstraints.first!.constant - translation.y, -550.0), 0.0)
            tableTopConstraint?.update(offset: newConstant)
            gestureRecognizer.setTranslation(.zero, in: contentContainerview)
        } else if gestureRecognizer.state == .ended {
            let velocity = gestureRecognizer.velocity(in: contentContainerview)
            
            if velocity.y > 0 {
                // Swipe down
                tableTopConstraint?.update(offset: 0.0)
            } else {
                // Swipe up
                tableTopConstraint?.update(offset: -550.0)
            }

            UIView.animate(withDuration: 0.5) {
                self.contentContainerview.layoutIfNeeded()
            }
        }
    }
    
    @objc private func selectedCalendar() {
        calendarMode?(true)
        isCalendarMode = true
    }
    
    @objc private func selectedList() {
        calendarMode?(false)
        isCalendarMode = false
    }
    
    private func setNavigationBarSelected() {
        calendarButton.setImage(.init(named: isCalendarMode ? "barCalendarSelected" : "barCalendar"), for: .normal)
        listButton.setImage(.init(named: isCalendarMode ? "barList" : "barListSelected"), for: .normal)
    }
}
