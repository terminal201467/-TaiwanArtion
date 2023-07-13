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
    var accountInput: BehaviorRelay<String> { get }
    var passwordInput: BehaviorRelay<String> { get }
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
    
    //MARK: -output
    var accountValidation: RxCocoa.Signal<ValidationResult> = Signal.just(.empty)
    var passwordValidSuccess: RxCocoa.Signal<[PasswordRequirement]> = Signal.just([])
    var isLocked: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isPrevented: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    //MARK: input/output
    var input: NormalLoginInput { self }
    var output: NormalLoginOutput { self }
    
    init() {
        accountInput.subscribe(onNext: { text in
            self.accountValidation = Signal.just(self.checkAccount(input: text))
        }).disposed(by: disposeBag)
        
        passwordInput.subscribe(onNext: { text in
            self.passwordValidSuccess = Signal.just(self.checkPassword(input: text))
        }).disposed(by: disposeBag)
        
        toPrevented.subscribe(onNext: { toPrevented in
            
        }).disposed(by: disposeBag)
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
