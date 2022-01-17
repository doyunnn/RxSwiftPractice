//
//  Article.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import Foundation

// MARK: - NewsArticleResponse
struct NewsArticleResponse: Codable {
    let articles: [NewsArticle]
    let status: String
    let totalResults: Int
}

// MARK: - NewsArticle
struct NewsArticle: Codable {
    let source: Source
    let author : String?
    let title : String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }

}


// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
