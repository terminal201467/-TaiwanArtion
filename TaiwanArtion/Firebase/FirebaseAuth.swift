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
    //Google登入
    func googleSignIn(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?, isLogginCompletion: @escaping (Bool) -> Void) {
        if let error = error {
            print("Google 登入發生錯誤：\(error.localizedDescription)")
            return
        }
        
        guard let idToken = user.idToken?.tokenString else { return }
        let accessToken = user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
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
}
