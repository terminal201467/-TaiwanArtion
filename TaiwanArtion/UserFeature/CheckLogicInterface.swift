//
//  CheckLogicInterface.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/17.
//

import Foundation

class CheckLogicInterface {
    
    //MARK: - MultipleCheckLogic
    //1.帳號輸入檢查
    private func checkAccount(_ account: String) -> Bool {
        ///4-21碼小寫英文.數字
        let accountRegex = "^[a-z0-9]{4,21}$"
        let accountPredicate = NSPredicate(format: "SELF MATCHES %@", accountRegex)
        return accountPredicate.evaluate(with: account)
    }
    
//    let testAccounts = ["abcd123", "Abcd123", "abcdefg12345678901234", "short", "toolongtoolongtoolong"]
//    for account in testAccounts {
//        if isValidAccount(account) {
//            print("\(account) is valid.")
//        } else {
//            print("\(account) is not valid.")
//        }
//    }
    
    //2.密碼輸入檢查
    private func checkPassword(_ password: String) -> Bool {
        ///6-18位數密碼,請區分大小寫
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]{6,18}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
//    let testPasswords = ["Pass123", "password", "SecurePass123", "short", "toolongtoolongtoolong"]
//    for password in testPasswords {
//        if isValidPassword(password) {
//            print("\(password) is valid.")
//        } else {
//            print("\(password) is not valid.")
//        }
//    }
    
    //3.密碼提示檢查
    private func checkPasswordHint(_ password: String) -> [String] {
        var hints: [String] = []

            let uppercaseRegex = ".*[A-Z]+.*"
            let lowercaseRegex = ".*[a-z]+.*"
            let alphanumericRegex = "^[a-zA-Z0-9]+$"
            let specialCharactersRegex = "^[a-zA-Z0-9\\p{P}]+$"
        
            ///1. 至少一個大寫字母
            if password.range(of: uppercaseRegex, options: .regularExpression) != nil {
                hints.append("包含至少一個大寫字母")
            }
        
            ///2. 至少一個小寫字母
            if password.range(of: lowercaseRegex, options: .regularExpression) != nil {
                hints.append("包含至少一個小寫字母")
            }
        
            ///3. 8-16位英、數字
            if password.count >= 8 && password.count <= 16 {
                if password.range(of: alphanumericRegex, options: .regularExpression) != nil {
                    hints.append("長度在8-16位且僅包含英文和數字")
                }
            }
        
            ///4. 僅能使用英文.數字或特殊標點符號
            if password.range(of: specialCharactersRegex, options: .regularExpression) != nil {
                hints.append("僅使用英文、數字或特殊標點符號")
            }
            
            return hints
    }
    
//    let testPasswords = ["Password123!", "Abcd1234", "SecurePass123", "short", "longlonglonglonglonglong"]
//    for password in testPasswords {
//        let passwordHints = checkPasswordHint(password)
//        if passwordHints.isEmpty {
//            print("\(password) 符合所有條件")
//        } else {
//            print("\(password) 不符合以下條件：\(passwordHints.joined(separator: ", "))")
//        }
//    }
    
    //4.密碼強度檢查
    private func checkPasswordStrenght(_ password: String) -> String {
        let verifiedCheckCondition = checkPasswordHint(password).count
        switch verifiedCheckCondition {
        case ..<1: return "無"
        case 1: return "弱"
        case 2: return "中"
        case 3: return "強"
        case 4: return "強"
        default: return "無"
        }
    }
    
    //5.驗證碼檢查
    private func checkVerifyCode(_ code: String) {
        //從UserDefault取出
    }
    
    //6.電子郵件檢查
    private func checkEmail(_ email: String) -> [String] {
        var errors: [String] = []
        
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            errors.append("電子郵件格式不正確")
        }
        
        let validDomains = [".com", ".tw", ".com.tw"]
        var hasValidDomain = false
        for domain in validDomains {
            if email.hasSuffix(domain) {
                hasValidDomain = true
                break
            }
        }
        if !hasValidDomain {
            errors.append("無效的郵件域名")
        }
        
        if !email.contains("@") {
            errors.append("缺乏 @ 符號")
        }
        
        if email.components(separatedBy: "@").count != 2 {
            errors.append("帳號格式不正確")
        }
        
        return errors
    }

    // 測試
//    let testEmails = ["test@example.com", "invalidemail", "user@example", "user@example.invalid", "user@example.tw"]
//    for email in testEmails {
//        let emailErrors = checkEmail(email)
//        if emailErrors.isEmpty {
//            print("\(email) 符合所有條件")
//        } else {
//            print("\(email) 不符合以下條件：\(emailErrors.joined(separator: ", "))")
//        }
//    }
    
    //7.手機號碼檢查
    private func checkPhoneNumber(_ phoneNumber: String) -> [String] {
        var errors: [String] = []
        
        let phoneNumberRegex = "^09[0-9]{8}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        
        if !phoneNumberPredicate.evaluate(with: phoneNumber) {
            errors.append("手機號碼格式不正確")
        }
        
        return errors
    }

    // 測試
//    let testPhoneNumbers = ["968351191", "0968351191", "09123456789", "123456789"]
//    for phoneNumber in testPhoneNumbers {
//        let phoneNumberErrors = checkPhoneNumber(phoneNumber)
//        if phoneNumberErrors.isEmpty {
//            print("\(phoneNumber) 符合所有條件")
//        } else {
//            print("\(phoneNumber) 不符合以下條件：\(phoneNumberErrors.joined(separator: ", "))")
//        }
//    }
    
    //8. 含有其他國籍碼的電話號碼檢查
    
}
