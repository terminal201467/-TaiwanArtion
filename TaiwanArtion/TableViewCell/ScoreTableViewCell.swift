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
        view.setSpecificRoundCorners(corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
        return view
    }()
    
    private let scoreGrayBar: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.roundCorners(cornerRadius: 5)
        return view
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = .grayTextColor
        return label
    }()
    
    lazy var scoreStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, scoreGrayBar, scoreLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.backgroundColor = .whiteGrayColor
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
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(90.0 / frame.width)
        }
        
        scoreGrayBar.addSubview(scoreBrownBar)
        scoreGrayBar.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(165.0 / frame.width)
            make.height.equalToSuperview().multipliedBy(12.0 / frame.height)
            make.centerY.equalToSuperview()
        }
        
        scoreBrownBar.snp.makeConstraints { make in
            make.centerY.equalTo(scoreGrayBar.snp.centerY)
            make.leading.equalTo(scoreGrayBar.snp.leading)
            make.height.equalTo(scoreGrayBar.snp.height)
            make.width.equalTo(scoreGrayBar.snp.width).multipliedBy(score / 10)
        }
    }
    
    func configure(title: String, score: Double) {
        titleLabel.text = title
        scoreLabel.text = "\(score)"
        self.score = score
    }
}
