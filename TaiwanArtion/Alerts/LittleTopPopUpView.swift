//
//  LittleTopPopUpView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

class LittleTopPopUpView: UIView {
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .black
        return view
    }()
    
    private let litleHint: UIButton = {
        let button = UIButton()
        button.roundCorners(cornerRadius: 12)
        button.backgroundColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(litleHint)
        litleHint.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(57.0)
        }
    }
    
    func configure(title: String, image: String) {
        litleHint.setTitle(title, for: .normal)
        litleHint.setImage(.init(named: image), for: .normal)
    }

}
