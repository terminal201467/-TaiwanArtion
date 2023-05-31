//
//  EvaluateView.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/30.
//

import UIKit
import RxSwift
import RxCocoa

class EvaluateView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var popViewController: (() -> Void)?
    
    var pushViewController: (()-> Void)?
    
    //MARK: -Background
    private let rightTopImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "evaluateTopRightBackground")
        return imageView
    }()
    
    private let leftIMiddleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "evaluateLeftTopBackground")
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.text = "撰寫評價"
        return label
    }()
    
    //MARK: -Foreground
    private let personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.roundCorners(cornerRadius: imageView.frame.size.width / 2.0)
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var personInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [personImage, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
    }()
    
    let backgroundWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setSpecificRoundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20.0)
        return view
    }()
    
    let starCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(StarCollectionViewCell.self, forCellWithReuseIdentifier: StarCollectionViewCell.reuseIdentifier)
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let slidersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SliderTableViewCell.self, forCellReuseIdentifier: SliderTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let evaluateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brownTitleColor
        button.setTitleColor(.white, for: .normal)
        button.roundCorners(cornerRadius: 20)
        button.setTitle("評價", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundAutoLayout()
        foregroundAutoLayout()
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func backgroundAutoLayout() {
        self.backgroundColor = .caramelColor
        addSubview(rightTopImage)
        rightTopImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addSubview(leftIMiddleImage)
        leftIMiddleImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(100.0)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(73.0)
        }
        
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(37.5)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func foregroundAutoLayout() {
        addSubview(backgroundWhiteView)
        backgroundWhiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150.0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        personImage.snp.makeConstraints { make in
            make.height.equalTo(120.0)
            make.width.equalTo(120.0)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(26.0)
        }
        
        backgroundWhiteView.addSubview(personInfoStack)
        personInfoStack.snp.makeConstraints { make in
            make.height.equalTo(150.0)
            make.width.equalTo(150.0)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16.0)
        }
        
        backgroundWhiteView.addSubview(starCollectionView)
        starCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(personInfoStack.snp.bottom).offset(16)
            make.width.equalTo(250.0)
            make.height.equalTo(32.0)
        }
        
        backgroundWhiteView.addSubview(slidersTableView)
        slidersTableView.snp.makeConstraints { make in
            make.leading.equalTo(backgroundWhiteView.snp.leading).offset(16)
            make.trailing.equalTo(backgroundWhiteView.snp.trailing).offset(-16)
            make.top.equalTo(starCollectionView.snp.bottom).offset(40.0)
            make.bottom.equalTo(backgroundWhiteView.snp.bottom)
        }
        
        addSubview(evaluateButton)
        evaluateButton.snp.makeConstraints { make in
            make.bottom.equalTo(slidersTableView.snp.bottom).offset(-40.0)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(40.0)
        }
    }
    
    private func setButton() {
        backButton.rx.tap
            .subscribe(onNext: {
                self.popViewController?()
            })
            .disposed(by: disposeBag)
        
        evaluateButton.rx.tap
            .subscribe(onNext: {
                self.pushViewController?()
            })
            .disposed(by: disposeBag)
    }
    
    func configure(personImageText: String, name: String) {
        personImage.image = UIImage(named: personImageText)
        nameLabel.text = name
    }
}
