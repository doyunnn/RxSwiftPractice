//
//  ProrfileViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import Foundation
import RxSwift
import RxCocoa
import GoogleSignIn
import FirebaseAuth
class ProfileViewModel {
    let email = UserDefaults.standard.string(forKey: "email")
    let scrapObservable = BehaviorRelay<[ScrapArticle]>(value: [])
    var scrapArticles = [ScrapArticle]()
    
    init(){
        guard let email = self.email else {return}
        DatabaseManager.shared.getScrapArticles(for: email)
            .take(1)
            .bind(to: scrapObservable)
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
    public func deleteScrapArticle(article: ScrapArticle,_ vc: ScrapListVC){
        DispatchQueue.main.async {
            
            guard let email = UserDefaults.standard.string(forKey: "email") else{
                return
            }
            
                let alert: UIAlertController = UIAlertController(title: "이 글을 삭제 하시겠습니까?", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                    DatabaseManager.shared.deleteScrapArticle(email: email,id: article.id) { deleted in
                        guard deleted else{
                            return
                        }
                        DispatchQueue.main.async {
                            let alert: UIAlertController = UIAlertController(title: "삭제 되었습니다.", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: {_ in
                                guard let email = self.email else {return}
                                DatabaseManager.shared.getScrapArticles(for: email)
                                    .take(1)
                                    .subscribe(onNext: {
                                        self.scrapObservable.accept($0)
                                    })
                            }))
                            vc.present(alert, animated: true, completion: nil)
                        }
                    }
                }))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
