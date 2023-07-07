//
//  RouteButtonTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ButtonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "ButtonTableViewCell"
    
    var action: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.roundCorners(cornerRadius: 20)
        button.backgroundColor = .brownColor
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setButtonSubscription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(40.0)
        }
    }
    
    private func setButtonSubscription() {
        button.rx.tap
            .subscribe(onNext: {
                self.action?()
            })
            .disposed(by: disposeBag)
    }
    
    func configure(buttonName: String) {
        button.setTitle(buttonName, for: .normal)
    }
}
