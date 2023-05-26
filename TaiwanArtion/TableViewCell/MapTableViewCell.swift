//
//  MapTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/26.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "MapTableViewCell"
    
    private let containerView: UIView = {
       let view = UIView()
        view.roundCorners(cornerRadius: 12)
        return view
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners(cornerRadius: 6)
        return view
    }()
    
    private let routeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "route"), for: .normal)
        return button
    }()
    
    private let routeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "路線"
        return label
    }()
    
    private lazy var routeStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [routeButton, routeLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("顯示詳細地圖", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let adressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationLabel, adressLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    private let map: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.roundCorners(cornerRadius: 12)
        map.isZoomEnabled = true
        return map
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(342.0 / frame.width)
            make.height.equalToSuperview().multipliedBy(400.0 / frame.height)
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(map)
        map.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        map.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(106.0 / 400.0)
            make.top.equalToSuperview().offset(16.0)
        }
        
        detailView.addSubview(routeStack)
        routeStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        detailView.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        detailView.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
    func configure(location: String, address: String) {
        locationLabel.text = location
        adressLabel.text = address
    }
}
