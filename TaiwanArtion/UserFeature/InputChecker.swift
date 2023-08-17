//
//  InputChecker.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/17.
//

import Foundation

protocol CheckerInput {
    
}

protocol CheckerOutput {
    
}

protocol CheckInputOutputType {
    
    var input: CheckerInput { get }
    
    var output: CheckerOutput { get }
}

class InputChecker {
    
    //MARK: -Input
    
    
    //MARK: -Output
    
    
    //MARK: -Logic Interface
    private let checkLogic = CheckLogicInterface()
    
    //MARK: -Input/Output
    
    //訂閱
    init() {
        
    }

}
