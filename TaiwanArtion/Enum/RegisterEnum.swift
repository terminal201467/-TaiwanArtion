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

