//
//  ExhibitionHallTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/1.
//

import UIKit
import RxSwift

class ExhibitionHallTableViewCell: UITableViewCell {
    
    private var isLike: Bool = false
    
    var isLikeAction: ((Bool) -> Void)?
    
    static let reuseIdentifier: String = "ExhibitionHallTableViewCell"
    
    private let disposeBag = DisposeBag()
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: 8)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayTextColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var locationStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationIcon, locationLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()
    
    private let timeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayTextColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var timeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeImage, timeLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationStack, timeStack])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, infoStack])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        view.roundCorners(cornerRadius: 12)
        return view
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var mainContentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainImage, contentStack])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setButtonSubscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        containerView.addSubview(mainContentStack)
        mainContentStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(mainContentStack.snp.trailing)
            make.top.equalTo(mainContentStack.snp.top)
        }
    }
    
    private func setButtonSubscribe() {
        likeButton.rx.tap
            .subscribe(onNext: {
                self.isLike.toggle()
                self.isLikeAction?(self.isLike)
            })
            .disposed(by: disposeBag)
    }
    
    func configure(exhibitionHallTitle: String, location: String, time: String) {
        titleLabel.text = exhibitionHallTitle
        locationLabel.text = location
        timeLabel.text = "營業時間" + time
        likeButton.setImage(.init(named: isLike ? "love" : "collect"), for: .normal)
    }
}
