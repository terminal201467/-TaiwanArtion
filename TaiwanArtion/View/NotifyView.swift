//
//  NotifyView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NotifyView: UIView {
    
    var notifyIsOn: ((Bool) -> Void)?
    
    var backAction: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    //MARK: - BackgroundView
    
    private let leftMiddleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "leftBackground")
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "通知"
        return label
    }()
    
    private let titleView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let notifyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.text = "推播通知"
        return label
    }()
    
    let switchItem: UISwitch = {
       let switchItem = UISwitch()
        switchItem.tintColor = .white
        switchItem.onTintColor = .brownTitleColor
        return switchItem
    }()
    
    private let notifyView: UIView = {
       let view = UIView()
        return view
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, notifyView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ExhibitionCardItemCell.self, forCellWithReuseIdentifier: ExhibitionCardItemCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = nil
        return collectionView
    }()
    
    //MARK: - ForegroundView
    
    private let backgroundWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.applyShadow(color: .black, opacity: 0.3, offset: CGSize(width: 1, height: 1), radius: 4)
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return view
    }()
    
    private let bellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bell")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let notificationSectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.text = "展覽通知"
        return label
    }()
    
    private let redDotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "redDot")
        return imageView
    }()
    
    private let unReadlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "(0)未讀"
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(NotifyTableViewCell.self, forCellReuseIdentifier: NotifyTableViewCell.reuseIdentifier)
        tableView.register(SystemTableViewCell.self, forCellReuseIdentifier: SystemTableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSwitchItem()
        setBackButton()
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func backgroundAutoLayout() {
        backgroundColor = .caramelColor
        addSubview(leftMiddleImage)
        leftMiddleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150.0)
            make.leading.equalToSuperview()
        }
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30.0)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(18.0)
            make.width.equalTo(18.0)
        }
        
        notifyView.addSubview(notifyLabel)
        notifyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        notifyView.addSubview(switchItem)
        switchItem.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100.0)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(self.snp.centerX)
        }
        
        addSubview(backgroundWhiteView)
        backgroundWhiteView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func foregroundAutoLayout() {
        backgroundWhiteView.addSubview(notificationSectionTitleLabel)
        notificationSectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.top.equalToSuperview().offset(16.0)
        }
        
        backgroundWhiteView.addSubview(unReadlabel)
        unReadlabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(notificationSectionTitleLabel.snp.centerY)
        }
        
        backgroundWhiteView.addSubview(redDotImage)
        redDotImage.snp.makeConstraints { make in
            make.centerY.equalTo(unReadlabel.snp.centerY)
            make.trailing.equalTo(unReadlabel.snp.leading).offset(-4)
            make.height.equalTo(4)
            make.width.equalTo(4)
        }
        
        backgroundWhiteView.addSubview(bellImage)
        bellImage.snp.makeConstraints { make in
            make.width.equalTo(240.0)
            make.height.equalTo(240.0)
        }
        
        backgroundWhiteView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(notificationSectionTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setSwitchItem() {
        switchItem.rx.isOn
            .subscribe(onNext: { isOn in
                self.notifyIsOn?(isOn)
            })
            .disposed(by: disposeBag)
    }
    
    private func setBackButton() {
        backButton.rx.tap
            .subscribe(onNext: {
                self.backAction?()
            })
            .disposed(by: disposeBag)
    }
    
    func setConfigureUnRead(isRead: Bool, unReadCount: Int?) {
        if isRead {
            //已讀
            redDotImage.isHidden = true
            unReadlabel.isHidden = true
        } else {
            //未讀
            redDotImage.isHidden = false
            unReadlabel.isHidden = false
            unReadlabel.text = "(\(unReadCount!))未讀"
        }
    }
    
    func setTableHasDataBy(count: Int) {
        if count == 0 {
            bellImage.isHidden = false
            tableView.isHidden = true
        } else {
            bellImage.isHidden = true
            tableView.isHidden = false
        }
    }
    
}
