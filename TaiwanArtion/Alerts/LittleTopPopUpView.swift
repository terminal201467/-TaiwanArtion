//
//  LittleTopPopUpView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

class LittleTopPopUpView: UIView {
    
    var dismissFromController: (() -> Void)?
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .black
        return view
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 12)
        view.backgroundColor = .white
        return view
    }()
    
    private let checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var hintStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkImage, hintLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedViewController))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissPresentedViewController() {
        dismissFromController?()
    }
    
    private func autoLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(57.0)
            make.height.equalTo(36.0)
            make.width.equalTo(162.0)
        }
        
        checkImage.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        whiteView.addSubview(hintStack)
        hintStack.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(title: String, image: String) {
        hintLabel.text = title
        checkImage.image = .init(named: image)
    }

}
