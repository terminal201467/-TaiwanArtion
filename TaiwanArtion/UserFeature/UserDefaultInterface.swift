//
//  UserDefaultInterface.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/16.
//

import Foundation

class UserDefaultInterface {
    
    static let shared = UserDefaultInterface()
    
    private let userDefaults = UserDefaults.standard
    
    //MARK: -UserDefault
    func setUsername(_ username: String) {
        userDefaults.set(username, forKey: "username")
        userDefaults.synchronize()
    }
    
    func getUsername() -> String? {
        return userDefaults.string(forKey: "username")
    }
    
    func setBirth(_ date: String) {
        userDefaults.set(date, forKey: "birth")
        userDefaults.synchronize()
    }
    
    func getBirth() -> String? {
        return userDefaults.string(forKey: "birth")
    }
    
    func setGender(_ gender: String) {
        userDefaults.set(gender, forKey: "gender")
        userDefaults.synchronize()
    }
    
    func getGender() -> String? {
        return  userDefaults.string(forKey: "gender")
    }
    
    func setPhoneNumber(number: String) {
        userDefaults.set(number, forKey: "phoneNumber")
        userDefaults.synchronize()
    }
    
    func getPhoneNumber() -> String? {
        return userDefaults.string(forKey: "phoneNumber")
    }
    
    func setEmail(_ email: String) {
        userDefaults.set(email, forKey: "email")
        userDefaults.synchronize()
    }
    
    func getEmail() -> String? {
        return userDefaults.string(forKey: "email")
    }
    
    func setHeadImage(_ image: String) {
        userDefaults.set(image, forKey: "headImage")
        userDefaults.synchronize()
    }
    
    func getHeadImage() -> String? {
        return userDefaults.string(forKey: "headImage")
    }
    
    func setDocumentID(identifier: String) {
        userDefaults.set(identifier, forKey: "documentID")
        userDefaults.synchronize()
    }
    
    func getDocumentID() -> String? {
        return userDefaults.string(forKey: "documentID")
    }
    
    func setStoreHabby(habbys: [String]) {
        userDefaults.set(habbys, forKey: "habbys")
        userDefaults.synchronize()
    }
    
    func getStoreHabby() -> [String]? {
        return userDefaults.array(forKey: "habbys") as? [String]
    }
    
    func setIsLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: "isLoggedIn")
        userDefaults.synchronize()
    }
    
    func getIsLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "isLoggedIn")
    }
    
}
