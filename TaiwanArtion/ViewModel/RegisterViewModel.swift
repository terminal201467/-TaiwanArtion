//
//  RegisterViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/14.
//

import Foundation

class RegisterViewModel {
    
    private var currentStep: RegisterStep = .phoneVerify
    
    var phoneVerifyStep: PhoneVerifyStep = .stepOne
    
    var accountPasswordStep: AccountPasswordVerifyStep = .stepOne
    
    var emailVerifyStep: EmailVerifyStep = .stepOne
    
    func getCurrentStep() -> RegisterStep {
        return currentStep
    }
    
    func setCurrentStep(step: RegisterStep) {
        currentStep = step
    }
    
    //MARK: -StepCollectionView
    func stepsNumberOfRowInSection(section: Int) -> Int{
        return RegisterStep.allCases.count
    }
    
    func stepsCellForRowAt(indexPath: IndexPath) -> (stepString: String, isSelected: Bool) {
        let isSelected = RegisterStep(rawValue: indexPath.row) == currentStep
        return (RegisterStep.allCases[indexPath.row].title, isSelected)
    }
    
    func didSelectedRowAt(indexPath: IndexPath) {
        currentStep = RegisterStep(rawValue: indexPath.row)!
    }
    
    //MARK: -ContentTableView
    func contentNumberOfSections() -> Int {
        switch currentStep {
        case .phoneVerify: return PhoneVerifyCell.allCases.count
        case .acountPassword: return AccountPasswordCell.allCases.count
        case .emailVerify: return EmailVerifyCell.allCases.count
        case .complete: return 1
        }
    }
    
    func contentNumberOfRowInSection(section: Int) -> Int {
        switch currentStep {
        case .phoneVerify:
            switch PhoneVerifyCell(rawValue: section) {
            case .verify: return 1
            case .nextButton: return 1
            case .none: return 1
            }
        case .acountPassword:
            switch AccountPasswordCell(rawValue: section) {
            case .account: return 1
            case .password: return 1
            case .passwordHint: return 1
            case .strengthHint: return 1
            case .nextButton: return 1
            case .none: return 1
            }
        case .emailVerify:
            switch EmailVerifyCell(rawValue: section) {
            case .hint: return 1
            case .email: return 1
            case .nextButton: return 1
            case .none: return 1
            }
        case .complete: return 1
            //沒有東西，跳出註冊成功頁
        }
    }
}
