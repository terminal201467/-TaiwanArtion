//
//  LikeCommentFooter.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/29.
//

import UIKit
import RxSwift

class LikeCommentFooter: UITableViewHeaderFooterView {
    
    var likeAction: (() -> Void)?

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.setTitle("有幫助的評價", for: .normal)
        button.titleLabel?.textColor = .grayTextColor
        button.addTarget(LikeCommentFooter.self, action: #selector(like), for: .touchDown)
        return button
    }()
    
    @objc private func like() {
        likeAction?()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
