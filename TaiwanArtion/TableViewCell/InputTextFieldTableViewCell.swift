//
//  InputTextFieldTableViewCell.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import UIKit

class InputTextFieldTableViewCell: UITableViewCell {

    
    private let disposeBag = DisposeBag()
    
    var sendAction: (() -> (Void))?

    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .grayTextColor
        textField.roundCorners(cornerRadius: 12)
        return textField
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()
    
    private let fogetHintButton: UIButton = {
        let button = UIButton()
        button.setTitle("忘記密碼", for: .normal)
        button.isHidden = true
        return button
    }()
    
    
}
