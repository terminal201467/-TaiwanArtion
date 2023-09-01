//
//  BirthTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit
import RxSwift
import RxCocoa

class BirthTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "BirthTableViewCell"
    
    var chooseYearAction: (() -> Void)?
    
    var chooseDateAction: (() -> Void)?
    
    private let disposeBag = DisposeBag()

    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayTextColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let yearChooseButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "downArrow"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var yearStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearLabel, yearChooseButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayTextColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let dateChooseButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "downArrow"), for: .normal)
        return button
    }()
    
    private lazy var dateStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, dateChooseButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.backgroundColor = .white
        return stackView
    }()
    
    let yearContainerView: UIView = {
       let view = UIView()
        view.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        view.roundCorners(cornerRadius: 10)
        view.backgroundColor = .white
        return view
    }()
    
    private let dateContainerView: UIView = {
        let view = UIView()
        view.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
         view.roundCorners(cornerRadius: 10)
        view.backgroundColor = .white
         return view
    }()
    
    private lazy var birthStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearContainerView, dateContainerView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setButton()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        yearChooseButton.rx.tap
            .subscribe { _ in
                self.chooseYearAction?()
            }
            .disposed(by: disposeBag)
        
        dateChooseButton.rx.tap
            .subscribe { _ in
                self.chooseDateAction?()
            }
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        contentView.backgroundColor = .white
        contentView.addSubview(birthStack)
        birthStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateChooseButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        yearChooseButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        yearContainerView.addSubview(yearStack)
        yearStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        
        yearContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(40)
        }
        
        dateContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(40)
        }
        dateContainerView.addSubview(dateStack)
        dateStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        
    }
    
    func configureYearLabel(year: String?) {
        yearLabel.textColor = year == nil ? .grayTextColor : .black
        yearLabel.text = year == nil ? "西元" : year!
    }
    
    func configureDateLabel(month: String?, date: String?) {
        dateLabel.textColor = month == nil || date == nil ? .grayTextColor : .black
        dateLabel.text = month == nil || date == nil ? "選擇日期" : "\(month!)月\(date!)日"
    }
}
