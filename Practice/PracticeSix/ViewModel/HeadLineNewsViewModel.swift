//
//  NewsViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import Foundation
import RxSwift
import RxCocoa
class HeadLineNewsViewModel {
    
    let headLineNewsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let scrapViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    init(){
        _ = NewsMnager.shared.fetchHeadLineArticles()
            .map{$0}
            .take(1)
            .bind(to: headLineNewsObservable)
        
    }
    
    func didTapScrap(article: NewsArticle,_ vc : ArticleVC){
        self.scrapViewModel.scrapObservable
            .observe(on: MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { articles in
                
                var arr = articles.filter{$0.urlToImage == article.urlToImage}
                print(arr)
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
                    vc.present(alert, animated: true, completion: {
                        DispatchQueue.main.async {
                            vc.tableView.reloadData()
                        }
                    })
                   
                }else{
                    let alert: UIAlertController = UIAlertController(title: "이미 스크랩한 글입니다.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                    vc.present(alert, animated: true, completion: nil)
                }
                
            })
            .disposed(by: disposeBag)
   
    }
}
