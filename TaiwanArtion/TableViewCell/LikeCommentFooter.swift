//
//  LikeCommentFooter.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit
import RxSwift

class LikeCommentFooter: UIView {
    
    var likeAction: (() -> Void)?

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.setTitle("有幫助的評價", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.grayTextColor, for: .normal)
        button.addTarget(self, action: #selector(like), for: .touchDown)
        return button
    }()
    
    @objc private func like() {
        likeAction?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
