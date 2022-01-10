//
//  Coordinator.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import Foundation
import UIKit
class Coordinator{
    let window : UIWindow
    
    init(window : UIWindow){
        self.window = window
    }
    
    func start(){
        let rootVC = PracticeTwoRootVC()
        let navigationRootVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigationRootVC
        window.makeKeyAndVisible()
    }
}