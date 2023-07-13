//
//  CalendarPopUpView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/11.
//

import UIKit
import SnapKit

class CalendarPopUpView: UIView {
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .black
        return view
    }()
    
    private let calendarContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.roundCorners(cornerRadius: 12)
        return view
    }()
    
    private let calendar = CustomCalendar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(calendarContainerView)
        calendarContainerView.snp.makeConstraints { make in
            make.height.equalTo(390.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        calendarContainerView.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
