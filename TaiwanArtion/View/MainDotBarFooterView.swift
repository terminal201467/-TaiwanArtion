//
//  MainDotBarFooterView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/23.
//

import UIKit
import RxSwift
import SnapKit

class MainDotBarFooterView: UIView {
    
    static let reuseIdentifier: String = "MainDotBarFooterView"
    
    var currentPage: Int = 1 {
        didSet {
            updatesDotBar()
        }
    }
    
    private let mainDotOneView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 5)
        return view
    }()
    
    private let mainDotTwoView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 5)
        return view
    }()
    
    private let mainDotThreeView: UIView = {
        let view = UIView()
        view.roundCorners(cornerRadius: 5)
        return view
    }()
    
    private lazy var bars: [UIView] = [mainDotOneView, mainDotTwoView, mainDotThreeView]
    
    private lazy var mainDotStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: bars)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
        updatesDotBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(mainDotStack)
        mainDotStack.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func updatesDotBar() {
        for (index, bar) in bars.enumerated() {
            if index == currentPage {
                UIView.animate(withDuration: 0.3) {
                    bar.backgroundColor = .brown
                    bar.snp.makeConstraints { make in
                        make.width.equalTo(10)
                        make.height.equalTo(10)
                    }
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    bar.backgroundColor = .whiteGrayColor
                    bar.snp.makeConstraints { make in
                        make.width.equalTo(15)
                        make.height.equalTo(10)
                    }
                }
            }
        }
    }
}
