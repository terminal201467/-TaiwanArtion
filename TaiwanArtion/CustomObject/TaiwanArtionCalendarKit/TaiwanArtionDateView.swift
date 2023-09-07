//
//  TaiwanArtionDateView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/5.
//

import UIKit

class TaiwanArtionDateView: UIView {
    
    var calendarType: CalendarType
    
    var selectedDate: ((Date) -> Void)?
    
    private lazy var overlayContainerView = UIView(frame: self.collectionView.frame)
    
    private lazy var overlayView: UIView = {
        let overlayView = UIView(frame: self.collectionView.frame)
        overlayView.backgroundColor = UIColor(white: 0.5, alpha: 0.5) // 半透明的灰色背景
        overlayContainerView.addSubview(overlayView)
        overlayView.isHidden = true // 初始時隱藏
        return overlayView
    }()
    
    init(frame: CGRect, type: CalendarType) {
        calendarType = type
        super.init(frame: frame)
        autoLayout()
        setDelegate()
        setCollectionViewPanGesture()
    }
    
    private let dateCalculator = DateCalculator()

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func autoLayout() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollectionViewPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        collectionView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        var panSelectedIndexPath: [IndexPath]?
        switch gesture.state {
        case .began:
            panSelectedIndexPath = []
        case .changed:
            let location = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: location) {
                panSelectedIndexPath?.append(indexPath)
                dateCalculator.multipleSelectedRowAt(indexPaths: panSelectedIndexPath ?? [])
                if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
                    let contentSubview = cell.backgroundImageView
                    overlayContainerView.addSubview(overlayView)
                    overlayContainerView.bringSubviewToFront(contentSubview)
                }
            }
            //cell的背景也會變成
        case .ended:
            print("ended")
            //如果有底下的Button的話，button就變成咖啡色
        default:
            break
        }
    }
    
    func setYearMonth(year: Int, month: Int) {
        dateCalculator.setCalendarYear(year: year)
        dateCalculator.setCalendarMonth(month: month)
    }
}

extension TaiwanArtionDateView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseIdentifier, for: indexPath) as! DateCollectionViewCell
        let isEvent = dateCalculator.eventDateCellForRowAt(indexPath: indexPath)
        let dateInfo = dateCalculator.dateCellForRowAt(indexPath: indexPath)
        cell.configure(dateString: dateInfo.dateString, isToday: dateInfo.isToday, isCurrentMonth: dateInfo.isCurrentMonth)
        cell.configureEventDot(isEvent: isEvent)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dateCalculator.singleDidSelectedRowAt(indexPath: indexPath)
        dateCalculator.selectedDateCompletion = { date in
            self.selectedDate?(date)
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - (16 * 2)) / 7
        let cellHeight = 40.0
        return .init(width: cellWidth, height: cellHeight)
    }
}
