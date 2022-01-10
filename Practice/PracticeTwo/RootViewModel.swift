//
//  RootViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import Foundation
import RxSwift

final class RootViewModel{
    let title = "Doyun News"
    
    private let articleManager : ArticleManagerProtocol
    
    init(articleManager:ArticleManagerProtocol){
        self.articleManager = articleManager
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]>{
        return articleManager.fetchNews().map {$0.map{ ArticleViewModel(article: $0)}}
    }
    
}
