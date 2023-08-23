//
//  MapAnnocationView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/22.
//

import UIKit
import MapKit

class MapAnnocationView: MKAnnotationView {

    static let reuseIdentifier: String = "MapAnnocationView"
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let pinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(pinImage)
        pinImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pinImage.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(number: Int, isSelected: Bool) {
        pinImage.image = UIImage(named: isSelected ? "locationSelectedPin" : "locationPin")
        numberLabel.text = "\(number)"
    }
}
