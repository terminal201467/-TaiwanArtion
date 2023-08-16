//
//  LoginViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol NormalLoginInput {
    
    //帳號Input
    var accountInput: BehaviorRelay<String> { get }
    //密碼Input
    var passwordInput: BehaviorRelay<String> { get }
    
    //登入Subject
    var loginActionSubject: PublishSubject<Void> { get }
    
    var toPrevented: BehaviorRelay<Bool> { get }
}

protocol NormalLoginOutput {

    var accountValidation: Signal<ValidationResult> { get }
    
    var passwordValidSuccess: Signal<[PasswordRequirement]> { get }
    
    var isLocked: BehaviorRelay<Bool> { get }
    
    var isPrevented: BehaviorRelay<Bool> { get }
    
}

protocol NormalLoginViewModelType {
    
    var input: NormalLoginInput { get }
    
    var output: NormalLoginOutput { get }
}

class LoginViewModel: NormalLoginInput, NormalLoginOutput, NormalLoginViewModelType {
        
    private let disposeBag = DisposeBag()
    
    //MARK: -input
    var accountInput: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var passwordInput: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var toPrevented: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var loginActionSubject: RxSwift.PublishSubject<Void> = PublishSubject()
    
    //MARK: -output
    var accountValidation: RxCocoa.Signal<ValidationResult> = Signal.just(.empty)
    
    var passwordValidSuccess: RxCocoa.Signal<[PasswordRequirement]> = Signal.just([])
    
    var isLocked: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var isPrevented: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    //MARK: - Firebase
    
    private let firebaseAuth = FirebaseAuth.shared
    
    //MARK: - UserDefault
    
    private let userDefaultInterface = UserDefaultInterface.shared
    
    //MARK: input/output
    var input: NormalLoginInput { self }
    
    var output: NormalLoginOutput { self }
    
    init() {
        accountInput.subscribe(onNext: { text in
            print("帳號輸入:\(text)")
            //檢查帳號
//            self.accountValidation = Signal.just(self.checkAccount(input: text))
        }).disposed(by: disposeBag)
        
        passwordInput.subscribe(onNext: { text in
            print("密碼輸入:\(text)")
            //檢查密碼
//            self.passwordValidSuccess = Signal.just(self.checkPassword(input: text))
        }).disposed(by: disposeBag)
        
        toPrevented.subscribe(onNext: { toPrevented in
            
            //容許密碼可見、不可見
            
        }).disposed(by: disposeBag)
        
        loginActionSubject.subscribe(onNext: {
            print("LoginSubject!")
            self.firebaseAuth.normalLogin(email: self.accountInput.value, password: self.passwordInput.value) { user in
                self.userDefaultInterface.setUsername(user.name)
                self.userDefaultInterface.setGender(user.gender)
                self.userDefaultInterface.setBirth(user.birth)
                self.userDefaultInterface.setEmail(user.email)
                self.userDefaultInterface.setPhoneNumber(number: user.phone)
                self.userDefaultInterface.setHeadImage(user.headImage)
                self.userDefaultInterface.setIsLoggedIn(true)
            }
        })
        .disposed(by: disposeBag)
    }
    
    //MARK: -Account
    private func checkAccount(input: String) -> ValidationResult {
        //檢查帳號
        
        return .empty
    }
    
    //MARK: -Password
    private func checkPassword(input: String) -> [PasswordRequirement] {
        //檢查密碼
        
        return []
    }
    
}
