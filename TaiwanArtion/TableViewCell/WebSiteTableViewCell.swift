//
//  WebSiteTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/2.
//

import UIKit
import RxSwift

class WebSiteTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "WebSiteTableViewCell"
    
    private let disposeBag = DisposeBag()
    
    var selectedWebSiteLink: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let linkTextButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.linkBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private let linkImageButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "linkIcon")?.withTintColor(.linkBlue, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var linkStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [linkTextButton, linkImageButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(56.0)
            make.leading.equalToSuperview().offset(16)
        }
        
        linkImageButton.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.width.equalTo(24.0)
        }
        
        contentView.addSubview(linkStack)
        linkStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(16)
        }
    }
    
    private func setButtonSubscribe() {
        linkTextButton.rx.tap
            .subscribe(onNext: {
                self.selectedWebSiteLink?()
            })
            .disposed(by: disposeBag)
        
        linkImageButton.rx.tap
            .subscribe(onNext: {
                self.selectedWebSiteLink?()
            })
            .disposed(by: disposeBag)
    }
    
    func configure(title: String, linkText: String) {
        titleLabel.text = title
        linkTextButton.setTitle(linkText, for: .normal)
    }
}
