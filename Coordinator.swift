//
//  Coordinator.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import Foundation
import UIKit
import GoogleSignIn

class Coordinator{
    let window : UIWindow
    
    
    
    init(window : UIWindow){
        self.window = window
    }
    
    func start(){
//        let rootVC = PracticeTwoRootVC(viewModel: RootViewModel(articleManager: ArticleManager()))
//        let rootVC = PracticeThreeRootVC()
//        let rootVC = PracticeFourRootVC()
//        let rootVC = PracticeFiveRootVC()
        let vc : UIViewController
        if GIDSignIn.sharedInstance()?.currentUser != nil{
            vc = PracticeSixRootVC()
        }else{
            vc = LoginVC()
        }
        
        let navigationRootVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationRootVC
        window.makeKeyAndVisible()
    }
}
