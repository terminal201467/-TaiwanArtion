//
//  ScoreTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/28.
//

import UIKit
import SnapKit

class ScoreTableViewCell: UITableViewCell {
    
    private var score: CGFloat = 0
    
    static let reuseIdentifier: String = "ScoreTableViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .grayTextColor
        return label
    }()
    
    private let scoreBrownBar: UIView = {
       let view = UIView()
        view.backgroundColor = .brownColor
        view.setSpecificRoundCorners(corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 10)
        return view
    }()
    
    private let scoreGrayBar: UIView = {
       let view = UIView()
        view.backgroundColor = .whiteGrayColor
        view.roundCorners(cornerRadius: 10)
        return view
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var scoreStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, scoreGrayBar, scoreLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout(with: score)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout(with score: CGFloat) {
        contentView.addSubview(scoreStack)
        scoreStack.snp.makeConstraints { make in
            make.height.equalTo(30.0)
            make.centerY.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        scoreGrayBar.addSubview(scoreBrownBar)
        scoreGrayBar.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(8.0 / frame.height)
            make.centerY.equalToSuperview()
        }
        
        scoreBrownBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(score / frame.width)
        }
    }
    
    func configure(title: String, score: Double) {
        titleLabel.text = title
        scoreLabel.text = "\(score)"
    }
}
