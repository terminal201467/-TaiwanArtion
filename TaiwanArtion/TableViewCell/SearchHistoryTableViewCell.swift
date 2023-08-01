//
//  SearchHistoryTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import UIKit
import RxSwift
import RxCocoa

class SearchHistoryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "SearchHistoryTableViewCell"
    
    var deleteHistory: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let historyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "close"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setButtonSubScribe()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        contentView.addSubview(historyImage)
        historyImage.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        
        contentView.addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setButtonSubScribe() {
        deleteButton.rx.tap
            .subscribe(onNext: {
                self.deleteHistory?()
            })
            .disposed(by: disposeBag)
    }
    
    func configure(history: String) {
        historyLabel.text = history
    }
}
