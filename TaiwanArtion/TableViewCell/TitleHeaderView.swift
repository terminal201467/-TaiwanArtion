//
//  TitleHeaderView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/22.
//

import UIKit
import RxSwift
import RxCocoa

class TitleHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier: String = "TitleHeaderView"
    
    var buttonAction: (() -> (Void))?
    
    private let disposeBag = DisposeBag()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.grayTextColor, for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        autoLayout()
        setCheckMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func configureYear(with text: String) {
        titleLabel.text = "\(text)年"
    }
    
    func configureTitle(with text: String) {
        titleLabel.text = text
    }
    
    func configureButton(with text: String) {
        button.setTitle(text, for: .normal)
    }
    
    private func setCheckMoreButton() {
        button.rx.tap
            .subscribe(onNext: {
                self.buttonAction?()
            })
            .disposed(by: disposeBag)
    }
}
