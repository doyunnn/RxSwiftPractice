//
//  SearchArticlesViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import Foundation
import RxRelay
import RxCocoa
class SearchArticlesViewModel {
    
    let searchObservable = BehaviorRelay<[NewsArticle]>(value: [])
    
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
}
