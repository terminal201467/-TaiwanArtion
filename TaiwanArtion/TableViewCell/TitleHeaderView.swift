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
    
    private let disposeBag = DisposeBag()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    let checkMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("查看更多", for: .normal)
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
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(checkMoreButton)
        checkMoreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-32)
        }
    }
    
    func configureYear(with text: String) {
        titleLabel.text = "\(text)年"
    }
    
    func configureTitle(with text: String) {
        titleLabel.text = text
    }
    
    private func setCheckMoreButton() {
        checkMoreButton.rx.tap
            .subscribe(onNext: {
                print("查看更多Action")
            })
            .disposed(by: disposeBag)
    }
}
