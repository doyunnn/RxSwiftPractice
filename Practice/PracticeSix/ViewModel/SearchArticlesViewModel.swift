//
//  SearchArticlesViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import Foundation
import RxSwift
import RxCocoa
class SearchArticlesViewModel {
    
    let searchObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let scrapViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    init(){}
    func search(searchWord: String){
        _ = NewsMnager.shared.searchArticles(searchWord:searchWord)
            .take(1)
            .subscribe(onNext: {
                self.searchObservable.accept($0)
                })
    }
    public func deleteSearchWord(textField: UITextField){
        textField.text = ""
    }
    func didTapScrap(article: NewsArticle,_ vc : UIViewController){
        self.scrapViewModel.scrapObservable
            .observe(on: MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { articles in
                let arr = articles.filter{$0.urlToImage == article.urlToImage}
                if arr.isEmpty {
                    let alert: UIAlertController = UIAlertController(title: "이 글을 스크랩 하시겠습니까?", message: "", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                        guard let email = UserDefaults.standard.string(forKey: "email") else{return}
                                DatabaseManager.shared.tryBookMark(with: article, email: email) { result in
                                    guard result else{
                                        return
                                    }
                                    print("성공")
                                   
                                }
                    }))
                    vc.present(alert, animated: true, completion: nil)
                   
                }else{
                    let alert: UIAlertController = UIAlertController(title: "이미 스크랩한 글입니다.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                    vc.present(alert, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
   
    }
}
