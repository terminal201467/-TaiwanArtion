//
//  SplashView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit

enum StepType: Int, CaseIterable{
    case stepOne = 0, stepTwo, stepThree, stepFour
    var buttonText: String {
        switch self {
        case .stepOne: return "Next"
        case .stepTwo: return "Next"
        case .stepThree: return "Next"
        case .stepFour: return "Get Started"
        }
    }
    
    var titleText: String {
        switch self {
        case .stepOne: return "早找展覽"
        case .stepTwo: return "附近展覽"
        case .stepThree: return "展覽月曆"
        case .stepFour: return "收藏展覽"
        }
    }
    
    var hintText: String {
        switch self {
        case .stepOne: return "讓你迅速找到你所喜愛的近期展覽"
        case .stepTwo: return "透過附近展覽，找到離你最近的有趣展覽！"
        case .stepThree: return "將喜歡的展覽加入您的專屬月曆中！"
        case .stepFour: return "將喜歡的展覽加入您的專屬月曆中！"
        }
    }
    
    var stepImage: String {
        switch self {
        case .stepOne: return "step1"
        case .stepTwo: return "step2"
        case .stepThree: return "step3"
        case .stepFour: return "step4"
        }
    }
}

class SplashView: UIView {
    
    //MARK: Forground Object
    let stepImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .brownTitleColor
        return label
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.tintColor = .grayTextColor
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, hintLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.roundCorners(cornerRadius: 20)
        button.backgroundColor = .brownColor
        button.setImage(UIImage(named: "next"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - Background Object
    let middleWaveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let topWaveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let bottomWaveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func foregroundAutoLayout() {
        addSubview(stepImageView)
        stepImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(330)
            make.height.equalTo(316)
        }
        
        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(stepImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(labelStack.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
    }
    
    private func backgroundAutoLayout() {
        addSubview(middleWaveImage)
        middleWaveImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(topWaveImage)
        topWaveImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        addSubview(bottomWaveImage)
        bottomWaveImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setBackgroundStep(by step: StepType) {
        switch step {
        case .stepOne:
            middleWaveImage.image = UIImage(named: "stepOneWave")
            middleWaveImage.isHidden = false
            topWaveImage.isHidden = true
            bottomWaveImage.isHidden = true
            backgroundColor = .toffeeColor
        case .stepTwo:
            topWaveImage.image = UIImage(named: "stepTwoWave1")
            middleWaveImage.image = UIImage(named: "stepTwoWave2")
            topWaveImage.isHidden = false
            middleWaveImage.isHidden = false
            bottomWaveImage.isHidden = true
            backgroundColor = .caramelColor
        case .stepThree:
            topWaveImage.image = UIImage(named: "stepThreeWave1")
            bottomWaveImage.image = UIImage(named: "stepThreeWave2")
            middleWaveImage.isHidden = true
            topWaveImage.isHidden = false
            bottomWaveImage.isHidden = false
            backgroundColor = .caramelColor
        case .stepFour:
            topWaveImage.image = UIImage(named: "stepFourWave1")
            bottomWaveImage.image = UIImage(named: "stepFourWave2")
            middleWaveImage.isHidden = true
            topWaveImage.isHidden = false
            bottomWaveImage.isHidden = false
            backgroundColor = .caramelColor
        }
    }
    
    func configureStepSetting(by step: StepType) {
        stepImageView.image = UIImage(named: step.stepImage)
        titleLabel.text = step.titleText
        hintLabel.text = step.hintText
        nextButton.setTitle(step.buttonText, for: .normal)
        if step == .stepFour {
            nextButton.imageView?.isHidden = true
        } else {
            nextButton.imageView?.isHidden = false
        }
    }
    
    func setBackgroundStepSetting(by step: StepType) {
        switch step {
        case .stepOne:
            backgroundColor = .toffeeColor
        case .stepTwo:
            backgroundColor = .caramelColor
        case .stepThree:
            backgroundColor = .caramelColor
        case .stepFour:
            backgroundColor = .caramelColor
        }
    }
    
    func setSkipBar () {
        
    }
}
