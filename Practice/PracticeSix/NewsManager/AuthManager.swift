//
//  AuthManager.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/20.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

final class AuthManager{
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init(){}
    
    public var isSignedIn : Bool{
        return auth.currentUser != nil
    }
    
    public func signIn(user: GIDGoogleUser, completion: @escaping (Bool) -> Void){
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print(error)
                return
            }else{
                UserDefaults.standard.set(user.profile.email, forKey: "email")
                print(authResult)
                completion(true)
 
            }
           
        }
        
    }
    public func signOut(completion: @escaping (Bool) -> Void){
        GIDSignIn.sharedInstance().signOut()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(true)
        }catch let signOutError as NSError{
            print(signOutError)
            completion(false)
        }
    }
    
}
