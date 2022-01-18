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
    
    
    init(){
        _ = NewsMnager.shared.fetchHeadLineArticles()
            .map{$0}
            .take(1)
            .bind(to: headLineNewsObservable)
        
    }
    
    func didTapBookMark(){
        print("bookMarked")
        
    }
}
