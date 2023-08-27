//
//  NearExhibitionDetailTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/27.
//

import UIKit
import RxSwift
import RxCocoa

class NearExhibitionDetailTableViewCell: UITableViewCell {

    let likeActionSignal: Signal<Void> = Signal.just(())
    
    private var isLiked: Bool = false {
        didSet {
            self.setLikeButton()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    static let reuseIdentifier: String = "NearExhibitionDetailTableViewCell"
    
    private let contentMainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: 8)
        return imageView
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let tagView: UIView = {
        let view = UIView()
        view.setSpecificRoundCorners(corners: [.layerMinXMaxYCorner,.layerMaxXMinYCorner], radius: 8)
        return view
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "collect"), for: .normal)
        return button
    }()
    
    //MARK: -EvaluateInfo
    private let starEvaluatelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "star")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let evaluateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var evaluatesStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starEvaluatelabel, starImage, evaluateLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    //MARK: -detailInfo
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let timeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "calendar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "locationIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var detailStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeImage, timeLabel, locationImage, locationLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setButtonSubscribe()
        setLikeButton()
    }
    
    private func autoLayout() {
        //圖片
        addSubview(contentMainImage)
        contentMainImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
            make.height.equalToSuperview().multipliedBy(180.0 / self.frame.height)
        }
        
        contentMainImage.addSubview(tagView)
        tagView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(40.0)
            make.height.equalTo(24.0)
        }
        
        tagView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        contentMainImage.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30.0)
            make.width.equalTo(30.0)
        }
        
        //title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentMainImage.snp.leading)
            make.top.equalTo(contentMainImage.snp.bottom).offset(6.5)
        }
        
        //評價
        addSubview(evaluatesStack)
        evaluatesStack.snp.makeConstraints { make in
            make.trailing.equalTo(contentMainImage.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        //詳細內容
        timeImage.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.width.equalTo(24.0)
        }
        
        locationImage.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.width.equalTo(24.0)
        }
        
        addSubview(detailStack)
        detailStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6.5)
            make.leading.equalTo(contentMainImage.snp.leading)
        }
    }
    
    private func setButtonSubscribe() {
        likeButton.rx.tap
            .subscribe({ _ in
                isLiked.toggle()
            })
            .bind(to: likeActionSignal)
            .disposed(by: disposeBag)
    }
    
    private func setLikeButton() {
        likeButton.setImage(.init(named: isLiked ? "collectSelect": "collect"), for: .normal)
    }
    
    //評價
    func evaluateConfigure(with info: ExhibitionInfo) {
        starEvaluatelabel.text = info.evaluation?.allCommentStar
        evaluateLabel.text = "(\(info.evaluation?.allCommentCount))"
    }
    
    //細節內容
    func detailConfigure(with info: ExhibitionInfo) {
        titleLabel.text = info.title
        timeLabel.text = info.time
        locationLabel.text = info.location
    }
}
