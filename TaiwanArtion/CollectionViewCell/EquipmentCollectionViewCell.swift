//
//  EquipmentCollectionViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/26.
//

import UIKit

class EquipmentCollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: <#T##[UIView]#>)
        stackView.axis =
        stackView.alignment =
        stackView.distribution =
        stackView.spacing =
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        
    }
    
    func configure() {
        
    }
    
}
