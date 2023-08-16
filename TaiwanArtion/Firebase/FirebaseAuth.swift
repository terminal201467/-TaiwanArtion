//
//  FirebaseAuth.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/15.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth
import Firebase

class FirebaseAuth {
    
    static let shared = FirebaseAuth()
    
    init() {
        setGoogleSignInConfiguration()
    }
    
    private func setGoogleSignInConfiguration() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    func googleSignInAction(with controller: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { authResult, error in
            if let error = error {
                print("error:\(error.localizedDescription)")
            }
            
            if let result = authResult {
                print(
                """
                userID:\(result.user.userID)
                name:\(result.user.profile?.name)
                email:\(result.user.profile?.email)
                url:\(result.user.profile?.imageURL(withDimension: .init()))
                client:\(result.user.configuration.clientID)
                accessToken:\(result.user.accessToken)
                refreshToken:\(result.user.refreshToken.tokenString)
                """
                )
            }
        }
    }
    
    //Google登入
    func googleSignIn(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?, isLogginCompletion: @escaping (Bool) -> Void) {
        if let error = error {
            print("Google 登入發生錯誤：\(error.localizedDescription)")
            return
        }
        
        guard let idToken = user.idToken else { return }
        let accessToken = user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                       accessToken: accessToken)
        
        // 使用 Firebase 認證憑證登入
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase 登入發生錯誤：\(error.localizedDescription)")
                return
            }
            print("使用者成功登入：\(authResult?.user.displayName ?? "未知使用者")")
            isLogginCompletion((authResult?.user.isEmailVerified)!)
        }
    }
    
    //GoogleSignOut
    func googleSignOut() {
        
    }
    
    //Facebook登入
    func facebookSignIn(didCompleteWith result: LoginManagerLoginResult?, error: Error?, isLogginCompletion: @escaping (Bool) -> Void) {
        if let error = error {
            print("Facebook 登入發生錯誤：\(error.localizedDescription)")
            return
        }
        
        guard let result = result, !result.isCancelled else {
            print("使用者取消了 Facebook 登入")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase 登入發生錯誤：\(error.localizedDescription)")
                return
            }
            print("使用者成功登入：\(authResult?.user.displayName ?? "未知使用者")")
            isLogginCompletion((authResult?.user.isEmailVerified)!)
        }
    }

    //一般註冊
    func normalCreateAccount(email: String, password: String, completionIsVerified: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("註冊失敗：\(error.localizedDescription)")
            } else {
                print("註冊成功，使用者名稱：\(authResult?.user.displayName ?? "未知")")
                completionIsVerified(authResult?.user.isEmailVerified ?? false)
            }
        }
    }
    //一般登入
    func normalLogin(email: String, password: String, completionIsVerified: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("登入失敗：\(error.localizedDescription)")
            } else {
                print("登入成功，使用者名稱：\(authResult?.user.displayName ?? "未知")")
                completionIsVerified(authResult?.user.isEmailVerified ?? false)
            }
        }
    }
    
    //手機號碼驗證
    func sendMessengeVerified(byPhoneNumber number: String) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true  // 開發測試用，實際使用需移除
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error sending verification code: \(error.localizedDescription)")
                return
            }
            print("verificationID:\(verificationID!)")
            // 將 verificationID 儲存起來，稍後用於驗證碼確認
            UserDefaults.standard.set(verificationID!, forKey: "authVerificationID")
        }
    }
    
    func verifyMessengeCode(byVerifyCode code: String, completion: @escaping (String) -> Void) {
        // 在某個按鈕點擊事件中處理
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let verificationCode = code // 使用者輸入的驗證碼

        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID ?? "",
            verificationCode: verificationCode
        )

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error verifying verification code: \(error.localizedDescription)")
                return
            }
            authResult?.additionalUserInfo?.username
            // 驗證成功，authResult 中包含使用者資訊
        }

    }
    
    func sendEmailVerified(byEmail email: String, byPassword password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }

            // 發送驗證郵件
            authResult?.user.sendEmailVerification(completion: { error in
                if let error = error {
                    print("Error sending verification email: \(error.localizedDescription)")
                    return
                }

                print("Verification email sent.")
            })
        }
    }
    
    func verifiedEmailCode(byEmail email: String, byPassword password: String, code: String) {
        let verificationCode = code // 使用者通過郵件接收到的驗證碼
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)

        Auth.auth().currentUser?.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                print("Error reauthenticating: \(error.localizedDescription)")
                return
            }
            // 驗證成功，更新你的使用者介面
            print("Email verification succeeded.")
        }
    }
}
