//
//  TaiwanArtionCalendar.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/5.
//

import Foundation
import UIKit

enum CalendarType {
    case withButton, withSearching, inExhibitionCalendar
}

class TaiwanArtionCalendar: UIView {
    
    var correctAction: (() -> Void)?
    
    private var isAllowSelect: Bool = false {
        didSet {
            setCorrectButton()
        }
    }
    
    enum CalendarWithButtonItems: Int, CaseIterable {
        case title = 0, week, date, button
    }

    enum CalendarItems: Int, CaseIterable {
        case title = 0, month, week, date
    }
    
    private var type: CalendarType
    
    init(frame: CGRect, type: CalendarType) {
        self.type = type
        super.init(frame: frame)
        autoLayoutContainer()
        addContentToContainer()
        addTitleToContainer(by: type)
    }
    
    //MARK: - ContainerViews
    private let titleViewContainer = UIView()
    
    private let monthViewContainer = UIView()
    
    private let weekViewContainer = UIView()
    
    private let dateViewContiner = UIView()
    
    private let buttonViewContainer = UIView()
    
    //MARK: - ContentViews
    
    private let monthView = TaiwanArtionMonthView()
    
    private let weekView = TaiwanArtionWeekView()
    
    private lazy var dateView = TaiwanArtionDateView(frame: .zero, type: type)
    
    private let correctButton: UIButton = {
        let button = UIButton()
        button.setTitle("確定", for: .normal)
        button.addTarget(self, action: #selector(correct), for: .touchDown)
        return button
    }()
    
    //MARK: - TitleViews
    
    private var titleView: UIView?
    
    private var monthChangedTitleView: TaiwanArtionMonthChangedView?
    
    private var yearChangedTitleView: TaiwanArtionYearChangedView?
    
    private var titleHeaderView: TitleHeaderView?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayoutContainer() {
        backgroundColor = .white
        addSubview(titleViewContainer)
        titleViewContainer.snp.makeConstraints { make in
            make.height.equalTo(40.0)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(monthViewContainer)
        monthViewContainer.snp.makeConstraints { make in
            make.height.equalTo(49.0)
            make.top.equalTo(titleViewContainer.snp.bottom).offset(17.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(weekViewContainer)
        weekViewContainer.snp.makeConstraints { make in
            make.top.equalTo(monthViewContainer.snp.bottom).offset(10.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40.0)
        }
        
        addSubview(dateViewContiner)
        dateViewContiner.snp.makeConstraints { make in
            make.height.equalTo(280.0)
            make.top.equalTo(weekViewContainer.snp.bottom).offset(16.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(buttonViewContainer)
        buttonViewContainer.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.top.equalTo(dateViewContiner.snp.bottom).offset(16.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func addContentToContainer() {
        monthViewContainer.addSubview(monthView)
        monthView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        weekViewContainer.addSubview(weekView)
        weekView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateViewContiner.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buttonViewContainer.addSubview(correctButton)
        correctButton.snp.makeConstraints { make in
            make.height.equalTo(39.0)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func addTitleToContainer(by type: CalendarType) {
        switch type {
        case .withButton:
            monthChangedTitleView = TaiwanArtionMonthChangedView()
            titleView = monthChangedTitleView
            buttonViewContainer.isHidden = false
        case .withSearching:
            titleHeaderView = TitleHeaderView()
            titleView = titleHeaderView
            buttonViewContainer.isHidden = true
        case .inExhibitionCalendar:
            yearChangedTitleView = TaiwanArtionYearChangedView()
            titleView = yearChangedTitleView
            buttonViewContainer.isHidden = true
        }
        titleViewContainer.addSubview(titleView!)
    }
    
    private func setCorrectButton() {
        correctButton.isEnabled = isAllowSelect ? true : false
        correctButton.backgroundColor = isAllowSelect ? .brownColor : .whiteGrayColor
        correctButton.setTitleColor(isAllowSelect ? .white : .middleGrayColor, for: .normal)
    }
    
    @objc private func correct() {
        correctAction?()
    }
}
