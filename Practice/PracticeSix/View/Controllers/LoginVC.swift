//
//  LoginVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {
    //MARK : Properties
    private let loginLabel : UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let googleButton : GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigure()
    }
    //MARK : Configure
    func defaultConfigure(){
        view.backgroundColor = .white
        view.addSubview(googleButton)
        googleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        googleButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        googleButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        view.addSubview(loginLabel)
        loginLabel.bottomAnchor.constraint(equalTo: googleButton.topAnchor,constant: -50).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    //MARK : Helpers

}
extension LoginVC : GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthManager.shared.signIn(user: user) { result in
            guard result else{return}
            DispatchQueue.main.async {
                let vc = PracticeSixRootVC()
                let navi = UINavigationController(rootViewController: vc)
                navi.modalPresentationStyle = .fullScreen
                navi.navigationItem.largeTitleDisplayMode = .never
                self.navigationController?.present(navi, animated: true, completion: nil)
            }
        }
    }
}
