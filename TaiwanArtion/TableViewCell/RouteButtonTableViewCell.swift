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

class RouteButtonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "RouteButtonTableViewCell"
    
    var startRoute: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let routeButton: UIButton = {
        let button = UIButton()
        button.setTitle("規劃路線", for: .normal)
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
        contentView.addSubview(routeButton)
        routeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(342.0 / frame.width)
            make.height.equalTo(40.0)
        }
    }
    
    private func setButtonSubscription() {
        routeButton.rx.tap
            .subscribe(onNext: {
                self.startRoute?()
            })
            .disposed(by: disposeBag)
    }
}
