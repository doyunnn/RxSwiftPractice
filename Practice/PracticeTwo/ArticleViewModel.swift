//
//  ArticleViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import Foundation

struct ArticleViewModel{
    private let article: Article
    
    var imageUrl: String?{
        return article.urlToImage
    }
    var title: String?{
        return article.title
    }
    var description: String?{
        return article.description
    }
    
    init(article: Article){
        self.article = article
    }
}
