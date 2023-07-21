//
//  CustomCalendar.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

enum CustomCalendarItems: Int, CaseIterable {
    case title = 0, week, date, button
}

enum Week: Int, CaseIterable {
    case mon = 0, tue, wed, thu, fri, sat, sun
    var text: String {
        switch self {
        case .mon: return "一"
        case .tue: return "二"
        case .wed: return "三"
        case .thu: return "四"
        case .fri: return "五"
        case .sat: return "六"
        case .sun: return "日"
        }
    }
}

class CustomCalendar: UIView {
    
    private let disposeBag = DisposeBag()
    
    var outputMonthAndDate: ((_ month: String, _ date: String) -> Void)?
    
    var dismissCalendar: (() -> Void)?
    
    var currentMonth: Month = .jan
    
    private let viewModel = CustomCalendarViewModel()

    private let calendarView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TitleMonthCollectionViewCell.self, forCellWithReuseIdentifier: TitleMonthCollectionViewCell.reuseIdentifier)
        collectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: WeekCollectionViewCell.reuseIdentifier)
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.reuseIdentifier)
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
}

extension CustomCalendar: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CustomCalendarItems.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch CustomCalendarItems(rawValue: section) {
        case .title: return 1
        case .week: return Week.allCases.count
        case .date: return 42
        case .button: return 1
        case .none: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CustomCalendarItems(rawValue: indexPath.section) {
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleMonthCollectionViewCell.reuseIdentifier, for: indexPath) as! TitleMonthCollectionViewCell
            cell.changedTitleMonth = {
                collectionView.reloadData()
            }
            cell.configure(currenMonth: currentMonth)
            cell.nextMonthAction = {
                self.viewModel.input.nextMonth.onNext(())
                collectionView.reloadData()
            }
            cell.preMonthAction = {
                self.viewModel.input.preMonth.onNext(())
                collectionView.reloadData()
            }
            viewModel.output.reloadCalendar.subscribe(onNext: {
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)
            return cell
        case .week:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.reuseIdentifier, for: indexPath) as! WeekCollectionViewCell
            cell.configure(title: Week.allCases[indexPath.row].text)
            return  cell
        case .date:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseIdentifier, for: indexPath) as! DateCollectionViewCell
            cell.configure(date: viewModel.dateCellForRowAt(indexPath: indexPath).dateString,
                           isToday: viewModel.dateCellForRowAt(indexPath: indexPath).isDateSelected,
                           isCurrentMonth: viewModel.dateCellForRowAt(indexPath: indexPath).isCurrentMonth)
            return cell
        case .button:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.reuseIdentifier, for: indexPath) as! ButtonCollectionViewCell
            cell.configureRoundButton(isAllowToTap: viewModel.output.isAllowToTap.value, buttonTitle: "確定")
            cell.action = {
                self.dismissCalendar?()
            }
            return cell
        case .none: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch CustomCalendarItems(rawValue: section) {
        case .title: return .init(top: 16, left: 16, bottom: 8, right: 16)
        case .week: return .init(top: 0, left: 5, bottom: 0, right: 5)
        case .date: return .init(top: 0, left: 5, bottom: 0, right: 5)
        case .button: return .init(top: 8, left: 16, bottom: 16, right: 16)
        case .none: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch CustomCalendarItems(rawValue: indexPath.section) {
        case .title:
            let cellHeight = (frame.height - 16 * 2 ) / 10
            let cellWidth = frame.width
            return .init(width: cellWidth, height: cellHeight)
        case .week:
            let cellWidth = (frame.width - 16 * 2) / 8
            let cellHeight = (frame.height - 16 * 2 ) / 10
            return .init(width: cellWidth, height: cellHeight)
        case .date:
            let cellWidth = (frame.width - 16 * 2) / 8
            let cellHeight = (frame.height - 16 * 2 ) / 10
            return .init(width: cellWidth, height: cellHeight)
        case .button:
            let cellHeight = (frame.height - 16 * 2) / 10
            let cellWidth = frame.width - 16 * 2
            return .init(width: cellWidth, height: cellHeight)
        case .none: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectedRowAt(indexPath: indexPath)
        outputMonthAndDate?(viewModel.output.sendOutSelecteMonthAndDate.value.month, viewModel.output.sendOutSelecteMonthAndDate.value.date)
        collectionView.reloadData()
    }
}
