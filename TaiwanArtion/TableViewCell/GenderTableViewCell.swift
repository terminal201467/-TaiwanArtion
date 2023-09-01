//
//  GenderTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit
import RxSwift
import RxCocoa

class GenderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "GenderTableViewCell"
    
    var action: (() -> Void)?
    
    private let disposeBag = DisposeBag()

    let containerView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 10)
        view.addBorder(borderWidth: 1, borderColor: .whiteGrayColor)
        view.backgroundColor = .white
        return view
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let chooseButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "downArrow"), for: .normal)
        return button
    }()
    
    private lazy var genderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genderLabel, chooseButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        chooseButton.rx.tap
            .subscribe(onNext: {
                self.action?()
            })
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        chooseButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        containerView.addSubview(genderStack)
        genderStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
    }
    
    func configure(gender: String?) {
        genderLabel.text = gender == nil ? "請選擇你的性別" : gender!
        genderLabel.textColor = gender == nil ? .grayTextColor : .black
    }
}
