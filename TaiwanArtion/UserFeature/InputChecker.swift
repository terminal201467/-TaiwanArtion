//
//  InputChecker.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/17.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol CheckerInput {
    //1.帳號輸入
    var accountInputRelay: BehaviorRelay<String> { get }
    
    //2.密碼輸入
    var passwordInputRelay: BehaviorRelay<String> { get }
    
    //5.驗證碼輸入
    var verifiedCodeInputRelay: BehaviorRelay<String> { get }
    
    //6.電子郵件輸入
    var emailVerifiedInputRelay: BehaviorRelay<String> { get }
    
    //7.手機號碼輸入
    var phoneVerifiedInputRelay: BehaviorRelay<String> { get }
}

protocol CheckerOutput {
    //1.帳號輸入檢查
    var accountCheckOutputSignal: Signal<Bool> { get }
    
    //2.密碼輸入檢查
    var passwordCheckOutputSignal: Signal<Bool> { get }
    
    //3.密碼提示檢查
    var passwordHintOutputSignal: Signal<[String]> { get }
    
    //4.密碼強度檢查
    var passwordStrenghtOutputSignal: Signal<String> { get }
    
    //5.驗證碼檢查
    var verifyCodeCheckOutputSignal: Signal<Bool> { get }
    
    //6.電子郵件檢查
    var emailCheckOutputSignal: Signal<[String]> { get }
    
    //7.手機號碼檢查
    var phoneNumberOutoutSignal: Signal<[String]> { get }
}

protocol CheckInputOutputType {
    
    var input: CheckerInput { get }
    
    var output: CheckerOutput { get }
}

class InputChecker: CheckInputOutputType, CheckerInput, CheckerOutput {
    
    private let disposeBag = DisposeBag()

    //MARK: -Input
    
    var accountInputRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var passwordInputRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var verifiedCodeInputRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var emailVerifiedInputRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var phoneVerifiedInputRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    //MARK: -Output
    
    var accountCheckOutputSignal: RxCocoa.Signal<Bool> = Signal.just(false)
    
    var passwordCheckOutputSignal: RxCocoa.Signal<Bool> = Signal.just(false)
    
    var passwordHintOutputSignal: RxCocoa.Signal<[String]> = Signal.just([])
    
    var passwordStrenghtOutputSignal: RxCocoa.Signal<String> = Signal.just("")
    
    var verifyCodeCheckOutputSignal: RxCocoa.Signal<Bool> = Signal.just(false)
    
    var emailCheckOutputSignal: RxCocoa.Signal<[String]> = Signal.just([])
    
    var phoneNumberOutoutSignal: RxCocoa.Signal<[String]> = Signal.just([])
    
    //MARK: -Logic Interface
    private let checkLogic = CheckLogicInterface()
    
    //MARK: -Input/Output
    
    var input: CheckerInput { self }
    
    var output: CheckerOutput { self }
    
    //訂閱
    init() {
        accountCheckOutputSignal = accountInputRelay
            .map({ text in
                return self.checkLogic.checkAccount(text)
            })
            .asSignal(onErrorJustReturn: false)
        
        passwordCheckOutputSignal = passwordInputRelay
            .map({ text in
                return self.checkLogic.checkPassword(text)
            })
            .asSignal(onErrorJustReturn: false)
        
        passwordHintOutputSignal = passwordInputRelay
            .map({ text in
                return self.checkLogic.checkPasswordHint(text)
            })
            .asSignal(onErrorJustReturn: [])
        
        passwordStrenghtOutputSignal = passwordInputRelay
            .map({ text in
                return self.checkLogic.checkPasswordStrenght(text)
            })
            .asSignal(onErrorJustReturn: "")
        
        verifyCodeCheckOutputSignal = verifiedCodeInputRelay
            .map({ text in
                return self.checkLogic.checkVerifyCode(text)
            })
            .asSignal(onErrorJustReturn: false)
        
        emailCheckOutputSignal = emailVerifiedInputRelay
            .map({ text in
                return self.checkLogic.checkEmail(text)
            })
            .asSignal(onErrorJustReturn: [])
        
        phoneNumberOutoutSignal = phoneVerifiedInputRelay
            .map({ text in
                return self.checkLogic.checkPhoneNumber(text)
            })
            .asSignal(onErrorJustReturn: [])
    }

}
