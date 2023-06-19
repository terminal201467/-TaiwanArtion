//
//  AccountPasswordViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/19.
//

import Foundation
import RxSwift
import RxCocoa

enum ValidationResult {
    case valid
    case empty
    case failed(message: String)
}

enum PasswordRequirement {
    case uppercaseLetter
    case lowercaseLetter
    case length
    case validCharacters
}

public protocol LoginViewModelInput: AnyObject {
    var onLogin: PublishRelay<(String, String)> { get }
}

public protocol LoginViewModelOutput: AnyObject {
    var loginSuccess: Signal<String> { get }
    var accountValidation: Observable<ValidationResult> { get }
    var passwordValidSuccess: Observable<[PasswordRequirement]> { get }
}

public protocol LoginViewModelType: AnyObject {
    var inputs: LoginViewModelInput { get }
    var outputs: LoginViewModelOutput { get }
}

class AccountPasswordViewModel: LoginViewModelInput, LoginViewModelOutput, LoginViewModelType {
    
    private let disposeBag = DisposeBag()
    
    var onLogin: PublishRelay<(String, String)>
    
    var loginSuccess: Signal<String>
    
    let loginButtonEnabled: Observable<Bool>
    
    var accountValidation: Observable<ValidationResult>
    
    var passwordValidSuccess: Observable<[PasswordRequirement]>
    
    var inputs: LoginViewModelInput { self }
    
    var outputs: LoginViewModelOutput { self }
    
    private var requirements: [PasswordRequirement] = []
    
    private init() {
        onLogin
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] account, password in

            })
            .disposed(by: disposeBag)
        
        accountValidation
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] account in
                
            })
            .disposed(by: disposeBag)
        
        passwordValidSuccess
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] password in
                
            })
            .disposed(by: disposeBag)
        
    }
    
    private func login(account: String, password: String, completion: @escaping (() -> Void)) {
        //AuthService
        completion()
        
    }
    
    private func validateAccount(_ account: String) -> ValidationResult {
        let usernameRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,16}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        
        if account.isEmpty {
            return .empty
        } else if !usernamePredicate.evaluate(with: account) {
            return .failed(message: "帳號格式不符合要求")
        } else {
            return .valid
        }
    }
    
    private func validatePassword(_ password: String) {
        // 至少一個大寫字母
        let uppercaseRegex = "(?=.*[A-Z])"
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex)
        if uppercasePredicate.evaluate(with: password) {
            requirements.append(.uppercaseLetter)
        }
        
        // 至少一個小寫字母
        let lowercaseRegex = "(?=.*[a-z])"
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseRegex)
        if lowercasePredicate.evaluate(with: password) {
            requirements.append(.lowercaseLetter)
        }
        
        // 8-16位英文和數字
        let lengthRegex = "[a-zA-Z\\d!@#$%^&*()\\-_=+{};:,<.>]{8,16}"
        let lengthPredicate = NSPredicate(format: "SELF MATCHES %@", lengthRegex)
        if lengthPredicate.evaluate(with: password) {
            requirements.append(.length)
        }
        
        // 僅能使用英文、數字或特殊標點符號
        let characterRegex = "^[a-zA-Z\\d!@#$%^&*()\\-_=+{};:,<.>]*$"
        let characterPredicate = NSPredicate(format: "SELF MATCHES %@", characterRegex)
        if characterPredicate.evaluate(with: password) {
            requirements.append(.validCharacters)
        }
    }
    
    func getPasswordRequirements() -> [PasswordRequirement] {
        return requirements
    }
}
