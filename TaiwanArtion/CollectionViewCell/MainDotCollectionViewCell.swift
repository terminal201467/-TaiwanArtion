//
//  MainDotCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/4.
//

import UIKit

class MainDotCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "MainDotCollectionViewCell"
    
    private var isCurrentDot: Bool = false {
        didSet {
            autoLayout()
        }
    }
    
    private let mainDotView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(mainDotView)
        if self.isCurrentDot {
            UIView.animate(withDuration: 0.2) {
                self.mainDotView.backgroundColor = .brownColor
                self.mainDotView.snp.makeConstraints { make in
                    make.height.equalTo(8.0)
                    make.width.equalTo(8.0)
                }
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.mainDotView.backgroundColor = .middleGrayColor
                self.mainDotView.snp.makeConstraints { make in
                    make.height.equalTo(8.0)
                    make.width.equalTo(20.0)
                }
            }
        }
    }
    
    func configure(isCurrentDot: Bool) {
        self.isCurrentDot = isCurrentDot
    }
}
