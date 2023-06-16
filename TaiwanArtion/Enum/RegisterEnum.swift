//
//  RegisterEnum.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/16.
//

import Foundation

enum RegisterStep: Int, CaseIterable {
    case phoneVerify = 0, acountPassword, emailVerify, complete
    var title: String {
        switch self {
        case .phoneVerify: return "手機認證"
        case .acountPassword: return "帳號密碼"
        case .emailVerify: return "信箱認證"
        case .complete: return "完成註冊"
        }
    }
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
        case .nextButton: "下一步"
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
