//
//  DateCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "DateCollectionViewCell"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView(image: .init(named: "calendarDateSelected"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let eventDotView: UIImageView = {
        let imageView = UIImageView(image: .init(named: "brownDot"))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(eventDotView)
        eventDotView.snp.makeConstraints { make in
            make.leading.equalTo(backgroundImageView.snp.leading)
            make.top.equalTo(backgroundImageView.snp.top)
        }
    }
    
    func configureEventDot(isEvent: Bool) {
        eventDotView.isHidden = !isEvent
    }
    
    func configure(dateString: String, isToday: Bool, isCurrentMonth: Bool) {
        dateLabel.text = dateString
        if isCurrentMonth {
            dateLabel.textColor = isToday ? .white : .black
        } else {
            dateLabel.textColor = .grayTextColor
        }
        backgroundImageView.isHidden = isToday ? false : true
    }
}
