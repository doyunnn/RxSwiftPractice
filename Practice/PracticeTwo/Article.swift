//
//  Article.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import Foundation

struct ArticleResponse:Codable{
    let status : String
    let totalResults: Int
    let articles : [Article]
}

struct Article : Codable{
    // JSON 형태의 데이터를 swift 구조체 형태로 변환 - Codable
    let autor : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage: String?
    let publishedAt: String?
}
