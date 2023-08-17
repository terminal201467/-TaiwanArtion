//
//  ExhibitionNothingSearchedView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import UIKit
import RxSwift
import RxRelay

enum ExhibitionNothingSearchType: Equatable {
    
    case exhibitionNothingSearch, exhibitionHallNothingSearch, newsNothingSearch, nothingFoundInNear
    var image: String {
        switch self {
        case .exhibitionNothingSearch: return "exhibitionNotFound"
        case .exhibitionHallNothingSearch: return "exhibitionHallNotFound"
        case .newsNothingSearch: return "newsNotFound"
        case .nothingFoundInNear: return "exhibitionNotFound"
        }
    }
    
    var title: String {
        switch self {
        case .exhibitionNothingSearch: return "還沒開始收藏展覽"
        case .exhibitionHallNothingSearch: return "還沒開始收藏展覽館"
        case .newsNothingSearch: return "還沒開始收藏展覽新聞"
        case .nothingFoundInNear: return ""
        }
    }
    
    var description: String {
        switch self {
        case .exhibitionNothingSearch: return "去看看有什麼最新展覽吧！"
        case .exhibitionHallNothingSearch: return "去看看有什麼最新展覽館吧！"
        case .newsNothingSearch: return "去看看現在有什麼最新展覽新聞吧！"
        case .nothingFoundInNear: return "換個關鍵字再試試看！"
        }
    }
    
    var buttonText: String {
        switch self {
        case .exhibitionNothingSearch: return "探索展覽"
        case .exhibitionHallNothingSearch: return "探索展覽館"
        case .newsNothingSearch: return "探索展覽新聞"
        case .nothingFoundInNear: return ""
        }
    }
}

class ExhibitionNothingSearchedView: UIView {
    
    var linkToOtherPage: (() -> Void)?
    
    var type: ExhibitionNothingSearchType
    
    var keyword: String = ""
    
    private let disposeBag = DisposeBag()
    
    private let nothingSearchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let linkToOtherPageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brownColor
        button.roundCorners(cornerRadius: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    init(frame: CGRect, type: ExhibitionNothingSearchType) {
        self.type = type
        super.init(frame: frame)
        autoLayout()
        setButtonSubscription()
        configure(keyword: keyword)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonSubscription() {
        linkToOtherPageButton.rx.tap
            .subscribe(onNext: {
                self.linkToOtherPage?()
            })
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        backgroundColor = .white
        addSubview(nothingSearchImage)
        nothingSearchImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        
        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(nothingSearchImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        addSubview(linkToOtherPageButton)
        linkToOtherPageButton.snp.makeConstraints { make in
            make.top.equalTo(labelStack.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(192.0)
        }
    }
    
    
    private func configure(keyword: String) {
        nothingSearchImage.image = .init(named: type.image)
        titleLabel.text = type == .nothingFoundInNear ? "哎呀，找不到「\(keyword)」相關的展覽館" : type.title
        descriptionLabel.text = type.description
        linkToOtherPageButton.setTitle(type.buttonText, for: .normal)
        linkToOtherPageButton.isHidden = type == .nothingFoundInNear ? true : false
    }
}
