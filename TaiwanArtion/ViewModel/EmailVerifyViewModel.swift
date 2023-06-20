//
//  EmailVerifyViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/20.
//

import Foundation

enum VerifyResponse: Int, CaseIterable {
    case verify = 0, unVerify
}

enum EmailVerifyStep: Int, CaseIterable {
    case stepOne = 0, stepTwo
}

enum EmailVerifyCell: Int, CaseIterable {
    case hint = 0, email, nextButton
    var stepOneText: String {
        switch self {
        case .hint: return "為了確保是你本人，我們將會寄送一封驗證信件到你的電子信箱。"
        case .email: return "電子信箱"
        case .nextButton: return "下一步"
        }
    }
    var stepTwoText: String {
        switch self {
        case .hint: return "已發送信箱驗證碼至eof*****@gmail.com,請輸入信箱驗證碼並送出驗證。"
        case .email: return "信箱驗證碼"
        case .nextButton: return "寄送信箱驗證碼"
        }
    }
}

class EmailVerifyViewModel {
    
    private var currentStep: EmailVerifyStep = .stepOne {
        didSet {
            self.cleanInputText()
        }
    }
    
    var isAllowSelectedNextButton : Bool = false
    
    var inputText: String = "" {
        didSet {
            self.checkAllowNextStep()
        }
    }
    
    func cleanInputText() {
        self.inputText = ""
    }
    
    func getCurrentStep() -> EmailVerifyStep {
        return currentStep
    }
    
    func setCurrentStep(step: EmailVerifyStep) {
        currentStep = step
    }
    
    func numberOfRowInSection(section: Int) -> Int{
        switch currentStep {
        case .stepOne: return 3
        case .stepTwo: return 3
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> String {
        switch currentStep {
        case .stepOne:
            switch EmailVerifyCell(rawValue: indexPath.row) {
            case .hint: return EmailVerifyCell.hint.stepOneText
            case .email: return ""
            case .nextButton: return EmailVerifyCell.nextButton.stepOneText
            case .none: return ""
            }
        case .stepTwo:
            switch EmailVerifyCell(rawValue: indexPath.row) {
            case .hint: return EmailVerifyCell.hint.stepTwoText
            case .email: return ""
            case .nextButton: return EmailVerifyCell.nextButton.stepTwoText
            case .none: return ""
            }
        }
    }
    
    private func checkAllowNextStep() {
        //這邊可能還需要補檢查的邏輯
        isAllowSelectedNextButton = inputText == "" ? false : true
    }
    
    //檢查電子郵件
    func checkEmailAccount(email: String) -> VerifyResponse {
        
        //Firebase發送認證信到個人信箱
        
        //如果輸入的驗證碼符合，回傳Verify
        
        //如果輸入的驗證碼不符合，回傳unVerify
        return .verify
    }
    
    //檢查認證碼
    func checkVerifyPassword(code: String) -> VerifyResponse {
        
        //取得驗證碼到APP上
        
        //如果符合
        
        //如果不符合
        return .verify
    }
}
