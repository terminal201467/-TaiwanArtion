//
//  PersonalFileView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import UIKit
import SnapKit
import RxSwift

class PersonalFileView: UIView {
    
    var changePhoto: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Background
    private let backgorundLineImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "line")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Foreground
    private let personImageButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "defaultPeronImage"), for: .normal)
        return button
    }()
    
    private let camaraButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "PersonFilePageCamara"), for: .normal)
        return button
    }()
    
    //MARK: - Containers
    private let personInfoContainerView = UIView()
    
    let tableContainerView: UIView = {
        let view = UIView()
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
        backgroundAutoLayout()
        foregroundAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        personImageButton.rx.tap
            .subscribe(onNext: {
                self.changePhoto?()
            })
            .disposed(by: disposeBag)
        
        camaraButton.rx.tap
            .subscribe(onNext: {
                self.changePhoto?()
            })
            .disposed(by: disposeBag)
    }
    
    private func backgroundAutoLayout() {
        backgroundColor = .caramelColor
        addSubview(backgorundLineImage)
        backgorundLineImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func foregroundAutoLayout() {
        addSubview(personInfoContainerView)
        personInfoContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        personInfoContainerView.addSubview(personImageButton)
        personImageButton.snp.makeConstraints { make in
            make.width.equalTo(120.0)
            make.height.equalTo(120.0)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(camaraButton)
        camaraButton.snp.makeConstraints { make in
            make.centerX.equalTo(personImageButton.snp.trailing).offset(-20)
            make.centerY.equalTo(personImageButton.snp.bottom).offset(-20)
        }
        
        addSubview(tableContainerView)
        tableContainerView.snp.makeConstraints { make in
            make.top.equalTo(personInfoContainerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configurePersonImageButton(image: Any) {
        personImageButton.setImage(image is String ? .init(named: image as! String) : .init(data: image as! Data), for: .normal)
    }
}
