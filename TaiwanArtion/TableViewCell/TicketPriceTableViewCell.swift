//
//  TicketPriceTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/26.
//

import UIKit

class TicketPriceTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "TicketPriceTableViewCell"
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .grayTextColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titlelabel, detailLabel, noteLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func autoLayout() {
        addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(title: String?, ticketType: String, price: String, note: String) {
        if let title = title {
            titlelabel.isHidden = false
            titlelabel.text = title
        } else {
            titlelabel.isHidden = true
        }
        detailLabel.text = "\(ticketType)" + " " + "$\(price)"
        noteLabel.text = note
    }
}
