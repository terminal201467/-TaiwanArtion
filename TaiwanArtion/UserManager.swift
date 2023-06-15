//
//  UserManager.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
        // 避免外部透過初始化方法建立新的實例
    }
    
    func setUsername(_ username: String) {
        userDefaults.set(username, forKey: "username")
        userDefaults.synchronize()
    }
    
    func getUsername() -> String? {
        return userDefaults.string(forKey: "username")
    }
    
    func setAge(_ age: Int) {
        userDefaults.set(age, forKey: "age")
        userDefaults.synchronize()
    }
    
    func getAge() -> Int {
        return userDefaults.integer(forKey: "age")
    }
    
    func setIsLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: "isLoggedIn")
        userDefaults.synchronize()
    }
    
    func getIsLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "isLoggedIn")
    }
    
    //MARK: - Firebase Code
}

