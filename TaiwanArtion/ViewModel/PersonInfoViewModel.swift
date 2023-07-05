//
//  PersonInfoViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/6.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

enum PersonInfo: Int, CaseIterable {
    case name = 0, gender, birth, email, phone
    var section: String {
        switch self {
        case .name: return "姓名"
        case .gender: return "性別"
        case .birth: return "生日"
        case .email: return "電子郵件"
        case .phone: return "手機號碼"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .name: return "請輸入你的姓名"
        case .gender: return "請選擇你的性別"
        case .birth: return "選擇日期"
        case .email: return "請輸入你的電子郵件"
        case .phone: return "請輸入你的手機號碼"
        }
    }
}

protocol PersonInfoInput {
    var nameInput: BehaviorRelay<String> { get }
    var genderInput: BehaviorRelay<String> { get }
    var birthInput: BehaviorRelay<String> { get }
    var emailInput: BehaviorRelay<String> { get }
    var phoneInput: BehaviorRelay<String> { get }
    var saveAction: PublishSubject<Void> { get }
}

protocol PersonInfoOutput {
    var saveCheck: BehaviorRelay<Bool> { get }
    var personInfo: Observable<[PersonInfo]> { get }
}

protocol PersonInfoViewModelType {
    var input: PersonInfoInput { get }
    var outout: PersonInfoOutput { get }
}


class PersonInfoViewModel: PersonInfoInput, PersonInfoOutput, PersonInfoViewModelType {
   
    private let disposeBag = DisposeBag()
    //MARK: -Input
    var nameInput: BehaviorRelay<String> = BehaviorRelay(value: "")
    var genderInput: BehaviorRelay<String> = BehaviorRelay(value: "")
    var birthInput: BehaviorRelay<String> = BehaviorRelay(value: "")
    var emailInput: BehaviorRelay<String> = BehaviorRelay(value: "")
    var phoneInput: BehaviorRelay<String> = BehaviorRelay(value: "")
    var saveAction: PublishSubject<Void> = PublishSubject<Void>()
    
    //MARK: -Output
    var saveCheck: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var personInfo: Observable<[PersonInfo]> = Observable.just(PersonInfo.allCases)
    
    //MARK: -Input、Output
    var input: PersonInfoInput { self }
    var outout: PersonInfoOutput { self }
    
    //MARK: -Initialization
    init() {
        nameInput.subscribe { text in
            print("nameInputText:\(text)")
        }
        .disposed(by: disposeBag)
        
        genderInput.subscribe { text in
            print("genderInput:\(text)")
        }
        .disposed(by: disposeBag)
        
        birthInput.subscribe { text in
            print("birthInput:\(text)")
        }
        .disposed(by: disposeBag)
        
        emailInput.subscribe { text in
            print("emailInput:\(text)")
        }
        .disposed(by: disposeBag)
        
        phoneInput.subscribe { text in
            print("phoneInput:\(text)")
        }
        .disposed(by: disposeBag)
        
        //checkInput is empty or not
        checkInput()
    }
    
    private func checkInput() {
        Observable.combineLatest(nameInput, genderInput, birthInput, emailInput, phoneInput)
            .map { name, gender, birth, email, phone in
                return !name.isEmpty && !gender.isEmpty && !birth.isEmpty && !email.isEmpty && !phone.isEmpty
            }
            .bind(to: saveCheck)
            .disposed(by: disposeBag)
    }
}
