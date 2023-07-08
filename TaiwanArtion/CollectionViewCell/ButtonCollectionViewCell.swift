//
//  ButtonCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/3.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ButtonCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ButtonCollectionViewCell"
    
    private var isImage: Bool = true
    
    private let disposeBag = DisposeBag()
    
    var action: (() -> Void)?
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
        imageAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imageAutoLayout() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func roundButtonAutoLayout() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40.0)
        }
    }
    
    private func setButton() {
        button.rx.tap
            .subscribe(onNext: {
                self.action?()
            })
            .disposed(by: disposeBag)
    }
    
    func configure(iconText: String) {
        button.setImage(UIImage(named: iconText), for: .normal)
    }
    
    func configureRoundButton(isAllowToTap: Bool, buttonTitle: String) {
        roundButtonAutoLayout()
        button.roundCorners(cornerRadius: 20)
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(isAllowToTap ? .white : .grayTextColor, for: .normal)
        button.backgroundColor = isAllowToTap ? .brownColor : .whiteGrayColor
    }
}
