//
//  UserManager.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/12.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import RxRelay
import RxSwift

protocol UserManagerInput {
    
    //輸入嗜好
    var updateHabbyRelay: BehaviorRelay<[String]> { get }
    
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
    var saveDataSubject: PublishSubject<Void> { get }
    
    //googleLogin
    var googleLoginSubject: PublishSubject<Void> { get }
    
    //facebookLogin
    var facebookLoginSubject: PublishSubject<Void> { get }
    
    //createAccount
    var normalCreateAccountPubished: PublishRelay<(account: String, password: String)> { get }
    
    //normalLogin
    var normalLoginAccountPublished: PublishRelay<(account: String, password: String)> { get }
}

protocol UserManagerOutput {
    
    //目前是會回覆登入或沒有登入的狀態
    var outputIsLoginedRelay: BehaviorRelay<Bool> { get }
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
    var outputStoreHeadImageRelay: BehaviorRelay<String> { get }
    
    //輸出google登入
    var outputGoogleLoginRelay: BehaviorRelay<Bool> { get }
    
    //輸出facebook登入
    var outputFacebookLoginRelay: BehaviorRelay<Bool> { get }
    
    //輸出一般註冊結果
    var outputNormalCreateAccountRelay: BehaviorRelay<Bool> { get }
    
    //輸出一般登入結果
    var outputNormalLoginRelay: BehaviorRelay<Bool> { get }
}

protocol UserInputOutputType {
    var input: UserManagerInput { get }
    var output: UserManagerOutput { get }
}

class UserManager: UserInputOutputType, UserManagerInput, UserManagerOutput {
    
    private let disposeBag = DisposeBag()
        
    static let shared = UserManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let appConfigure = FirebaseApp.configure()
    
    private let fireBaseDataBase = FirebaseDatabase(collectionName: "users")
    
    private let fireBaseAuth = FirebaseAuth()
    
    //MARK: -Stream
    
    var input: UserManagerInput { self }
    
    var output: UserManagerOutput { self }
    
    //MARK: -Input
    
    var updateHabbyRelay: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [""])
    
    var updateNameRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var updateBirthRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var updateGenderRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var updatePhoneNumberRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var updateEmailRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var updateHeadImageRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var saveDataSubject: RxSwift.PublishSubject<Void> = PublishSubject()
    //ThirdPartyKitLoginRelay
    var googleLoginSubject: RxSwift.PublishSubject<Void> = PublishSubject()
    
    var facebookLoginSubject: RxSwift.PublishSubject<Void> = PublishSubject()
    //Normal
    var normalCreateAccountPubished: RxRelay.PublishRelay<(account: String, password: String)> = PublishRelay()
    
    var normalLoginAccountPublished: RxRelay.PublishRelay<(account: String, password: String)> = PublishRelay()
    
    //MARK: -Output
    
    var outputIsLoginedRelay: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var outputStoreNameRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var outputStoreBirthRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var outputStoreGenderRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var outputStorePhoneNumberRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var outputStoreEmailRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var outputStoreHeadImageRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var outputGoogleLoginRelay: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var outputFacebookLoginRelay: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var outputNormalCreateAccountRelay: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var outputNormalLoginRelay: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private init() {
        //input訂閱
        updateNameRelay.subscribe(onNext: { name in
            self.setUsername(name)
        })
        .disposed(by: disposeBag)
        
        updateGenderRelay.subscribe(onNext: { gender in
            self.setGender(gender)
        })
        .disposed(by: disposeBag)
        
        updateBirthRelay.subscribe(onNext: { birth in
            self.setBirth(birth)
        })
        .disposed(by: disposeBag)
        
        updateEmailRelay.subscribe(onNext: { email in
            self.setEmail(email)
        })
        .disposed(by: disposeBag)
        
        updateHabbyRelay.subscribe(onNext: { habbys in
            self.setStoreHabby(habbys: habbys)
        })
        .disposed(by: disposeBag)
        
        updateHeadImageRelay.subscribe(onNext: { headImage in
            self.setHeadImage(headImage)
        })
        .disposed(by: disposeBag)
        
        updatePhoneNumberRelay.subscribe(onNext: { phoneNumber in
            self.setPhoneNumber(number: phoneNumber)
        })
        .disposed(by: disposeBag)
        
        saveDataSubject.subscribe(onNext: {
            print("Save!")
            self.uploadUserInfoToFireBase()
        })
        .disposed(by: disposeBag)
        
        googleLoginSubject.subscribe(onNext: {
            print("Google Login")
            self.googleLogin { isLogin in
                print("isGoogleLogin Result:\(isLogin)")
                self.outputGoogleLoginRelay.accept(isLogin)
            }
        })
        .disposed(by: disposeBag)
        
        facebookLoginSubject.subscribe(onNext: {
            print("Facebook Login")
            self.facebookLogin { isLogin in
                print("isFaceBookLogin Result:\(isLogin)")
                self.outputFacebookLoginRelay.accept(isLogin)
            }
        })
        .disposed(by: disposeBag)
        
        normalCreateAccountPubished.subscribe(onNext: { account, password in
            self.normalCreateUser(email: account, password: password) { displayName in
                self.outputNormalCreateAccountRelay.accept(displayName)
            }
        })
        .disposed(by: disposeBag)
        
        normalLoginAccountPublished.subscribe(onNext: { account, password in
            self.normalUserLogin(email: account, password: password) { displayName in
                self.outputNormalLoginRelay.accept(displayName)
            }
        })
        .disposed(by: disposeBag)
        
        //output訂閱
        outputIsLoginedRelay.accept(getIsLoggedIn())
        
        outputStoreNameRelay.accept(getUsername() ?? "未輸入名字")
        
        outputStoreGenderRelay.accept(getGender() ?? "未輸入性別")
        
        outputStoreEmailRelay.accept(getEmail() ?? "未輸入Email")
        
        outputStoreBirthRelay.accept(getBirth() ?? "未輸入生日")
        
        outputStoreHeadImageRelay.accept(getHeadImage() ?? "未輸入大頭照")
        
        outputStorePhoneNumberRelay.accept(getPhoneNumber() ?? "未輸入電話號碼")
        
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
    
    private func setStoreHabby(habbys: [String]) {
        userDefaults.set(habbys, forKey: "habbys")
        userDefaults.synchronize()
    }
    
    private func getStoreHabby() -> [String]? {
        return userDefaults.array(forKey: "habbys") as? [String]
    }
    
    private func setIsLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: "isLoggedIn")
        userDefaults.synchronize()
    }
    
    private func getIsLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "isLoggedIn")
    }
    
    //MARK: - FirebaseAuth
    //Google驗證
    func googleLogin(completionIsVerified: @escaping (Bool) -> Void) {
        fireBaseAuth.googleSignIn(.sharedInstance, didSignInFor: .none, withError: .none) { isEmailVerified in
            completionIsVerified(isEmailVerified)
        }
    }
    
    //Facebook驗證
    func facebookLogin(completionIsVerified: @escaping (Bool) -> Void) {
        fireBaseAuth.facebookSignIn(didCompleteWith: .none, error: nil) { isEmailVerified in
            completionIsVerified(isEmailVerified)
        }
    }
    
    //一般用戶驗證
    func normalCreateUser(email: String, password: String, completionIsVerified: @escaping (Bool) -> Void) {
        fireBaseAuth.normalCreateAccount(email: email, password: password) { isVerified in
            completionIsVerified(isVerified)
        }
    }
    
    //一般用戶登入
    func normalUserLogin(email: String, password: String, completionIsVerified: @escaping (Bool) -> Void) {
        fireBaseAuth.normalLogin(email: email, password: password) { isVerified in
            completionIsVerified(isVerified)
        }
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
