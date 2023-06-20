//
//  EvaluateSucceedView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit
import RxSwift
import RxCocoa

class CompleteSucceedView: UIView {
    
    var topButtonAction: (() -> Void)?
    
    var bottomButtonAction: (() -> Void)?

    //MARK: - Background
    private let pointBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PointBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "evaluateSuccessTopRightBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "evaluateSuccessfulBottomLeftBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let middleCheersImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cheers")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Foreground
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .brownTitleColor
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .grayTextColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let topButton: UIButton = {
        let button = UIButton()
        button.roundCorners(cornerRadius: 20)
        button.backgroundColor = .brownColor
        return button
    }()
    
    private let bottomButton: UIButton = {
        let button = UIButton()
        button.roundCorners(cornerRadius: 20)
        button.backgroundColor = .white
        button.addBorder(borderWidth: 1, borderColor: .brownColor)
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topButton, bottomButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.isHidden = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
        setSubScriptionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func backgroundAutoLayout() {
        
        addSubview(topImage)
        topImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(bottomImage)
        bottomImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(pointBackground)
        pointBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(middleCheersImage)
        middleCheersImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func foregroundAutoLayout() {
        addSubview(titleStack)
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(middleCheersImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setSubScriptionButton() {
        topButton.rx.tap
            .subscribe(onNext: {
                self.topButtonAction?()
            })
            .disposed(by: DisposeBag())
        bottomButton.rx.tap
            .subscribe(onNext: {
                self.bottomButtonAction?()
            })
            .disposed(by: DisposeBag())
    }
    
    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    func configureButtons(topButtonName: String, bottomButtonName: String) {
        topButton.setTitle(topButtonName, for: .normal)
        bottomButton.setTitle(bottomButtonName, for: .normal)
    }
    
}
