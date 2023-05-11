//
//  StartViewController.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/11.
//

import UIKit
import SnapKit

class StartView: UIView {

    private let startLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStartLogoAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStartLogoAutoLayout() {
        backgroundColor = .white
        addSubview(startLogo)
        startLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(208)
            make.height.equalTo(80)
        }
    }
}
