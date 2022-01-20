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
    
    func didTapBookMark(){
        print("bookMarked")
        
    }
}
