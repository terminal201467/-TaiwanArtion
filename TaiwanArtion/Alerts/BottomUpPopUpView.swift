//
//  BottomUpPopUpView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit
import RxSwift
import RxCocoa

enum FilterItems: Int, CaseIterable {
    case open = 0, highEvaluate, recent
    var text: String {
        switch self {
        case .open: return "營業中"
        case .highEvaluate: return "最高評價"
        case .recent: return "距離最近"
        }
    }
}

class BottomUpPopUpView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var filterCondition: ((String) -> Void)?
    
    private var currentSelectedItem: FilterItems?

    private let backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .black
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 12)
        return view
    }()
    
    private let toolBar: UIToolbar = {
        let barTitle = UIBarButtonItem(title: "篩選", style: .done, target: self, action: nil)
       let toolBar = UIToolbar()
        toolBar.setItems([barTitle], animated: false)
        return  toolBar
    }()
    
    private let openButton: UIButton = {
        let button = UIButton()
        button.setTitle("營業中", for: .normal)
        return button
    }()
    
    private let highEvaluateButton: UIButton = {
        let button = UIButton()
        button.setTitle("最高評價", for: .normal)
        return button
    }()
    
    private let recentButton: UIButton = {
        let button = UIButton()
        button.setTitle("距離最近", for: .normal)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [openButton, highEvaluateButton, recentButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
        setButtonSubscribe()
        setButtonSelectedColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonSubscribe() {
        openButton.rx.tap
            .subscribe(onNext: {
                self.filterCondition?(FilterItems.open.text)
                self.currentSelectedItem = .open
            })
            .disposed(by: disposeBag)
        
        highEvaluateButton.rx.tap
            .subscribe(onNext: {
                self.filterCondition?(FilterItems.highEvaluate.text)
                self.currentSelectedItem = .highEvaluate
            })
            .disposed(by: disposeBag)
        
        recentButton.rx.tap
            .subscribe(onNext: {
                self.filterCondition?(FilterItems.recent.text)
                self.currentSelectedItem = .recent
            })
            .disposed(by: disposeBag)
    }
    
    private func setButtonSelectedColor() {
        switch currentSelectedItem {
        case .open:
            openButton.setTitleColor(.brownColor, for: .normal)
            highEvaluateButton.setTitleColor(.black, for: .normal)
            recentButton.setTitleColor(.black, for: .normal)
        case .highEvaluate:
            openButton.setTitleColor(.black, for: .normal)
            highEvaluateButton.setTitleColor(.brownColor, for: .normal)
            recentButton.setTitleColor(.black, for: .normal)
        case .recent:
            openButton.setTitleColor(.black, for: .normal)
            highEvaluateButton.setTitleColor(.black, for: .normal)
            recentButton.setTitleColor(.brownColor, for: .normal)
        case .none: print("none")
        }
    }
    
    private func autoLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(185.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        containerView.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(39.0)
        }
        
        containerView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(toolBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
