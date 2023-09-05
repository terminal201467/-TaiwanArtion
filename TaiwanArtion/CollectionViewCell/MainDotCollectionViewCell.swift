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
            updateUI()
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
        mainDotView.backgroundColor = .middleGrayColor
        mainDotView.snp.makeConstraints { make in
            make.height.equalTo(8.0)
            make.width.equalTo(20.0)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(isCurrentDot: Bool) {
        self.isCurrentDot = isCurrentDot
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.2) {
            self.mainDotView.backgroundColor = self.isCurrentDot ? .brownColor : .middleGrayColor
            self.mainDotView.snp.updateConstraints { make in
                make.width.equalTo(self.isCurrentDot ? 8.0 : 20.0)
            }
            self.layoutIfNeeded()
        }
    }
}
