//
//  EquipmentCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/26.
//

import UIKit

class EquipmentCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "EquipmentCollectionViewCell"
    
    private let checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "check")
        return imageView
    }()
    
    private let equipmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        return label
    }()
    
    private lazy var checkEquipmentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkImage, equipmentLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
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
        contentView.addSubview(checkEquipmentStack)
        checkEquipmentStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo((frame.width - 16 * 2) / 2)
        }
    }
    
    func configure(equipment: String) {
        equipmentLabel.text = equipment
    }
}
