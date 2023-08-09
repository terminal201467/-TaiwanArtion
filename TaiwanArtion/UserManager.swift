//
//  UserManager.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import RxRelay
import RxSwift

protocol UserManagerInput {
    
    //輸入嗜好
    var updateHabbyRelay: BehaviorRelay<String> { get }
    
    //輸入使用者名字
    var updateNameRelay: BehaviorRelay<String> { get }
    
    //輸入出生年月日
    var updateBirthRelay: BehaviorRelay<String> { get }
    
    //輸入性別
    var updateGenderRelay: BehaviorRelay<String> { get }
    
    //輸入聯絡方式
    var updatePhoneNumberRelay: BehaviorRelay<String> { get }
    
    //輸入email
    var updateEmailRelay: BehaviorRelay<String> { get }
    
    //輸入照片
    var updateHeadImageRelay: BehaviorRelay<String> { get }
    
    //儲存資料
    var saveDataPublished: PublishRelay<Void> { get }
}

protocol UserManagerOutput {
    
    //目前是會回覆登入或沒有登入的狀態
    var isLoginedRelay: BehaviorRelay<Bool> { get }
    ///怎麼樣會顯示為：有登入、沒有登入？
    
    //取得使用者名字
    var outputStoreNameRelay: BehaviorRelay<String> { get }
    
    //取得出生年月日
    var outputStoreBirthRelay: BehaviorRelay<String> { get }
    
    //取得性別
    var outputStoreGenderRelay: BehaviorRelay<String> { get }
    
    //取得聯絡方式
    var outputStorePhoneNumberRelay: BehaviorRelay<String> { get }
    
    //取得email
    var outputStoreEmailRelay: BehaviorRelay<String> { get }
    
    //取得照片
    var outputStoreHeadImage: BehaviorRelay<String> { get }
}

class UserManager {
    
    static let shared = UserManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let fireBaseDataBase = FirebaseDatabase(collectionName: "users")
    
    private let fireBaseAuth = FirebaseAuth()
    
    //MARK: -Input
    
    //MARK: -Output
    
    private init() {
        //input訂閱
        
        //output訂閱
    }
    
    //MARK: -UserDefault
    private func setUsername(_ username: String) {
        userDefaults.set(username, forKey: "username")
        userDefaults.synchronize()
    }
    
    private func getUsername() -> String? {
        return userDefaults.string(forKey: "username")
    }
    
    private func setBirth(_ date: String) {
        userDefaults.set(date, forKey: "birth")
        userDefaults.synchronize()
    }
    
    private func getBirth() -> String? {
        return userDefaults.string(forKey: "birth")
    }
    
    private func setGender(_ gender: String) {
        userDefaults.set(gender, forKey: "gender")
        userDefaults.synchronize()
    }
    
    private func getGender() -> String? {
        return  userDefaults.string(forKey: "gender")
    }
    
    private func setPhoneNumber(number: String) {
        userDefaults.set(number, forKey: "phoneNumber")
        userDefaults.synchronize()
    }
    
    private func getPhoneNumber() -> String? {
        return userDefaults.string(forKey: "phoneNumber")
    }
    
    private func setEmail(_ email: String) {
        userDefaults.set(email, forKey: "email")
        userDefaults.synchronize()
    }
    
    private func getEmail() -> String? {
        return userDefaults.string(forKey: "email")
    }
    
    private func setHeadImage(_ image: String) {
        userDefaults.set(image, forKey: "headImage")
        userDefaults.synchronize()
    }
    
    private func getHeadImage() -> String? {
        return userDefaults.string(forKey: "headImage")
    }
    
    private func setDocumentID(identifier: String) {
        userDefaults.set(identifier, forKey: "documentID")
        userDefaults.synchronize()
    }
    
    private func getDocumentID() -> String? {
        return userDefaults.string(forKey: "documentID")
    }
    
    //MARK: - Loggin Situation
    func setIsLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: "isLoggedIn")
        userDefaults.synchronize()
    }
    
    func getIsLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "isLoggedIn")
    }
    
    //MARK: - FirebaseAuth
    //Google驗證
    func googleLogin(completion: @escaping (Bool) -> Void) {
        fireBaseAuth.googleSignIn(.sharedInstance, didSignInFor: .none, withError: .none) { isEmailVerified in
            completion(isEmailVerified)
        }
    }
    
    //Facebook驗證
    func facebookLogin(completion: @escaping (Bool) -> Void) {
        fireBaseAuth.facebookSignIn(didCompleteWith: .none, error: nil) { isEmailVerified in
            completion(isEmailVerified)
        }
    }
    
    //一般用戶驗證
    func createNormalUser(email: String, password: String, completion: @escaping () -> Void) {
        fireBaseAuth.normalCreateAccount(email: email, password: password)
    }
    
    func normalUserLogin(email: String, password: String, compltion: @escaping (Bool) -> Void) {
        fireBaseAuth.normalLogin(email: email, password: password)
    }
    
    //MARK: - FireBaseDataBase
    //後台資料上傳
    private func uploadUserInfoToFireBase() {
        let storeUserInfo = ["birth" : getBirth(),
                    "email" : getEmail(),
                    "gender" : getGender(),
                    "headImage" : getHeadImage(),
                    "phone" : getPhoneNumber(),
                    "username" : getUsername()]
        fireBaseDataBase.createDocument(data: storeUserInfo) { documentID, error in
            if let error = error {
                print("上傳使用者資訊Error:\(error.localizedDescription)")
            }
            print("documentID:\(documentID)")
            self.setDocumentID(identifier: documentID ?? "未知的ID")
        }
    }
    
    private func readUserInfoFromFireBase(documentID: String, completion: @escaping (User) -> Void) {
        fireBaseDataBase.readDocument(documentID: documentID) { data, error in
            if let error = error {
                print("error:\(error)")
            } else if let data = data {
                guard let username = data["username"] as? String,
                      let birth = data["birth"] as? String,
                      let email = data["email"] as? String,
                      let gender = data["gender"] as? String,
                      let phone = data["phone"] as? String,
                      let headImage = data["headImage"] as? String else { return }
                let userInfo = User(name: username, gender: gender, phone: phone, email: email, birth: birth, headImage: headImage)
                completion(userInfo)
            }
        }
    }
}
