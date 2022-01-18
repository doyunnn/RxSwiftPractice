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
    
    let newsObservable = BehaviorRelay<[NewsArticle]>(value: [])
    
    lazy var articleCnt = newsObservable.map {$0.count}
    
    init(){
        _ = NewsMnager.shared.fetchHeadLineArticles()
            .map{$0}
            .take(1)
            .bind(to: newsObservable)
        
    }
    
    func didTapBookMark(){
        print("bookMarked")
        
    }
}
