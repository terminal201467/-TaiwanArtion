//
//  HabbyCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import UIKit
import SnapKit

class HabbyCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "HabbyCollectionViewCell"
    
    private let habbyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let habbyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var habbyStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [habbyImage, habbyLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.roundCorners(cornerRadius: 10)
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        habbyLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(45)
        }
        
        habbyImage.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(habbyStack)
        habbyStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureImageAndLabel(by item: HabbyItem) {
        habbyImage.image = UIImage(named: item.imageText)
        habbyLabel.text = item.habbyTitleText
    }
    
    func configureHabby(by item: HabbyItem, isSelected: Bool) {
        habbyLabel.text = item.habbyTitleText
        configureItem(by: item, selected: isSelected)
    }
    
    func handleSelectedItemView(by selected: Bool) {
        if selected {
            habbyStack.addBorder(borderWidth: 2, borderColor: .brownColor)
            habbyImage.tintColor = .brownColor
            habbyLabel.textColor = .brownColor
        } else {
            habbyStack.addBorder(borderWidth: 0, borderColor: .tintColor)
            habbyImage.tintColor = .middleGrayColor
            habbyLabel.textColor = .middleGrayColor
        }
    }
    
    private func configureItem(by item: HabbyItem, selected: Bool) {
        if selected {
            habbyImage.image = UIImage(named: item.homeHabbyImageText + "Selected")
        } else {
            habbyImage.image = UIImage(named: item.homeHabbyImageText)
        }
    }
}
