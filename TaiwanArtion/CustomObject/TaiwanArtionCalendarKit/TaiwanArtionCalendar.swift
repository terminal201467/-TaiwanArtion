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
    }
    
    //MARK: - ContainerViews
    private let titleViewContainer = UIView()
    
    private let monthViewContainer = UIView()
    
    private let weekViewContainer = UIView()
    
    private let dateViewContiner = UIView()
    
    //MARK: - ContentViews
    
    private let monthView = TaiwanArtionMonthView()
    
    private let weekView = TaiwanArtionWeekView()
    
    private lazy var dateView = TaiwanArtionDateView(frame: .zero, type: type)
    
    //MARK: - TitleViews
    
    private var titleView: UIView?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayoutContainer() {
        addSubview(titleViewContainer)
        titleViewContainer.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(40.0 / self.frame.height)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(monthViewContainer)
        monthViewContainer.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(49.0 / self.frame.height)
            make.top.equalTo(titleViewContainer.snp.bottom).offset(17.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(weekViewContainer)
        weekViewContainer.snp.makeConstraints { make in
            make.top.equalTo(monthViewContainer.snp.bottom).offset(10.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(40.0 / self.frame.height)
        }
        
        addSubview(dateViewContiner)
        dateViewContiner.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(280.0 / self.frame.height)
            make.top.equalTo(weekViewContainer.snp.bottom).offset(16.0)
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
    }
    
    private func addTitleToContainer(by type: CalendarType) {
        switch type {
        case .withButton:
            let view = TaiwanArtionMonthChangedView()
            titleView = view
            view.configureTitle(with: )
            titleViewContainer.addSubview(titleView)
            //新增ButtonView到尾端
        case .withSearching:
            //新增titleView到titleContainer
        case .inExhibitionCalendar:
            //新增
        }
    }
}
