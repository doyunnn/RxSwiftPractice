//
//  NewsViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewModel {
    //MAKR: Properties
    let appleNewsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let teslaNewsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let bitcoinNewsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let businessNewsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let techNewsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    let viewModel = PublishSubject<NewsArticle>()
    let scrapViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    init(){
        bindAppleNews()
//        bindTeslaNews()
//        bindbitcoinNews()
//        bindbusinessNews()
//        bindtechNews()
    }
    
    //MARK : Helpers
    func bindAppleNews(){
        _ = NewsMnager.shared.fetchAppleArticles()
            .map{
                var arr = [NewsArticle]()
                for i in 0...4{
                    arr.append($0[i])
                }
                return arr
            }
            .take(1)
            .bind(to: appleNewsObservable)
    }
    func bindTeslaNews(){
        _ = NewsMnager.shared.fetchTeslaArticles()
            .map{
                var arr = [NewsArticle]()
                for i in 0...4{
                    arr.append($0[i])
                }
                return arr
            }
            .take(1)
            .bind(to: teslaNewsObservable)
    }
    func bindbitcoinNews(){
        _ = NewsMnager.shared.fetchBitcoinArticles()
            .map{
                var arr = [NewsArticle]()
                for i in 0...4{
                    arr.append($0[i])
                }
                return arr
            }
            .take(1)
            .bind(to: bitcoinNewsObservable)
    }
    func bindbusinessNews(){
        _ = NewsMnager.shared.fetchBusinessArticles()
            .map{
                var arr = [NewsArticle]()
                for i in 0...4{
                    arr.append($0[i])
                }
                return arr
            }
            .take(1)
            .bind(to: businessNewsObservable)
    }
    func bindtechNews(){
        _ = NewsMnager.shared.fetchTechcrunchArticles()
            .map{
                var arr = [NewsArticle]()
                for i in 0...4{
                    arr.append($0[i])
                }
                return arr
            }
            .take(1)
            .bind(to: techNewsObservable)
    }
    
    func didTapApple(tableView : UITableView){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    func didTapTesla(tableView : UITableView){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: UITableView.ScrollPosition.top, animated: true)
    }
    func didTapBitcoin(tableView : UITableView){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: UITableView.ScrollPosition.top, animated: true)
    }
    func didTapBusiness(tableView : UITableView){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: UITableView.ScrollPosition.top, animated: true)
    }
    func didTapTech(tableView : UITableView){
        tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: UITableView.ScrollPosition.top, animated: true)
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
