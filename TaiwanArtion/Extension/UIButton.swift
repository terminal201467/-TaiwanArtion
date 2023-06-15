//
//  UIButton.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import UIKit

extension UIButton {
    
    func hollowBrownRoundborder() {
        self.roundCorners(cornerRadius: 20)
        self.addBorder(borderWidth: 1, borderColor: .brownTitleColor)
        self.backgroundColor = .white
        self.setTitleColor(.brownTitleColor, for: .normal)
    }
    
}
