//
//  ProrfileViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
class ProfileViewModel {
    
    
    init(){
        
    }
    
    public func logout(vc: UIViewController){
        AuthManager.shared.signOut { result in
            guard result else {return}
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                loginVC.modalPresentationStyle = .fullScreen
                vc.present(loginVC, animated: true, completion: nil)
            }
        }
        print("Signed out")
    }
}
