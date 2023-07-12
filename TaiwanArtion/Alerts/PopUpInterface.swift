//
//  PopUpInterface.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/12.
//

import UIKit

class PopUpInterface {
    
    private var isPopUpVisible = false
    
    func popUp(in parentView: UIView, popUpView: UIView) {
        guard !isPopUpVisible else { return } // 已經彈出時，不執行彈出邏輯
        parentView.addSubview(popUpView)
        popUpView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(parentView.snp.bottom).offset(popUpView.frame.height)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp(_:)))
        popUpView.addGestureRecognizer(tapGesture)
        
        UIView.animate(withDuration: 0.3) {
            popUpView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            parentView.layoutIfNeeded()
        } completion: { _ in
            self.isPopUpVisible = true
        }
    }
    
    func dismiss(in parentView: UIView, popUpView: UIView) {
        guard isPopUpVisible else { return } // 沒有彈出時，不執行消失邏輯
        popUpView.snp.updateConstraints { make in
            make.bottom.equalTo(parentView.snp.bottom).offset(popUpView.frame.height)
        }
        UIView.animate(withDuration: 0.3) {
            // 設定視圖的最終位置，移至畫面底部之外
            parentView.layoutIfNeeded()
        } completion: { _ in
            popUpView.removeFromSuperview()
            self.isPopUpVisible = false
        }
    }
    
    @objc private func dismissPopUp(_ gesture: UITapGestureRecognizer) {
        guard let popUpView = gesture.view else { return }
        dismiss(in: <#T##UIView#>, popUpView: popUpView)
    }

}
