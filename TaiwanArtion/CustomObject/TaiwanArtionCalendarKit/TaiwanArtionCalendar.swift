//
//  TaiwanArtionCalendar.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/5.
//

import Foundation
import UIKit


class TaiwanArtionCalendar: UIView {
    
    enum CalendarType {
        case withButton, withSearching, inExhibitionCalendar
    }
    
    enum CalendarWithButtonItems: Int, CaseIterable {
        case title = 0, week, date, button
    }

    enum CalendarItems: Int, CaseIterable {
        case title = 0, month, week, date
    }
    
    private var type: CalendarType
    
    init(frame: CGRect, type: CalendarType) {
        super.init(frame: frame)
        setDelegate()
        autoLayout()
    }
    
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
