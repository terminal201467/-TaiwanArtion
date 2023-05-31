//
//  SliderTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "SliderTableViewCell"
    
    var sliderValue: ((Int) -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .brownTitleColor
        slider.minimumTrackTintColor = .sliderBrownColor
        slider.maximumTrackTintColor = .whiteGrayColor
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayTextColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scoreSliderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [slider, scoreLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, scoreSliderStack])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    @objc func sliderValueChanged(_ silder: UISlider) {
        self.sliderValue?(Int(slider.value.rounded()))
        scoreLabel.text = "\(Int(slider.value.rounded()))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        slider.snp.makeConstraints { make in
            make.width.equalTo(frame.width * 0.9)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.width.equalTo(20.0)
        }
        
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
