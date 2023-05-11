//
//  SkipView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit
import RxSwift
import RxCocoa

class SkipView: UIView {
    
    var currentSteps: Int = 0 {
        didSet {
            updateBars()
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private let stepOneView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 4)
        return view
    }()
    
    private let stepTwoView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 4)
        return view
    }()
    
    private let stepThreeView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 4)
        return view
    }()
    
    private let stepFourView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 4)
        return view
    }()
    
    lazy var bars: [UIView] = [stepOneView, stepTwoView, stepThreeView, stepFourView]
    
    private lazy var stepsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: bars)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        return stackView
    }()

    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.brownColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
        setButtonBinding()
        updateBars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonBinding() {
        skipButton.rx.tap
            .subscribe(onNext: {
                self.currentSteps += 1
            })
            .disposed(by: disposeBag)
    }
    
    private func autoLayout() {
        addSubview(stepsView)
        addSubview(skipButton)
        stepsView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(15)
        }
        
        skipButton.snp.makeConstraints { make in
            make.leading.equalTo(stepsView.snp.trailing).offset(15)
            make.centerY.equalTo(stepsView.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(15)
        }
    }
    
    private func updateBars() {
        for (index, bar) in bars.enumerated() {
            if index == currentSteps {
                UIView.animate(withDuration: 0.3) {
                    bar.backgroundColor = .brown
                    bar.snp.updateConstraints { make in
                        make.width.equalToSuperview().multipliedBy(25 / 390)
                        make.height.equalToSuperview().multipliedBy(12 / 844)
                    }
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    bar.backgroundColor = .white
                    bar.snp.updateConstraints { make in
                        make.width.equalToSuperview().multipliedBy(64 / 390)
                        make.height.equalToSuperview().multipliedBy(12 / 844)
                    }
                    self.layoutIfNeeded()
                }
            }
        }
    }

}
