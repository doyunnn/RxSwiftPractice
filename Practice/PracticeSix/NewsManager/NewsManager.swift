//
//  NewsManager.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import Foundation
import RxSwift
import Alamofire


class NewsMnager {
    static let shared = NewsMnager()
    init(){}
    
    func fetchHeadLineArticles() -> Observable<[NewsArticle]> {
        return Observable.create { observer -> Disposable in
            self.fetchHeadLineArticles(){ error, articles in
                if let error = error {
                    observer.onError(error)
                }
                if let articles = articles {
                    observer.onNext(articles)
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    
    
    private func fetchHeadLineArticles(completion: @escaping((Error?, [NewsArticle]?) -> Void)){

        let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d6734920e71d413b9a73a1dd694ed445"
        guard let url = URL(string: urlString) else {
            return completion(NSError(domain: "doyun", code: 404, userInfo: nil),nil)
        }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseDecodable(of: NewsArticleResponse.self){ response in
                if let error = response.error{
                    return completion(error,nil)
                }
                if let articles = response.value?.articles{
                    return completion(nil,articles)
                }
            }
    }
    
    func fetchAppleArticles() ->Observable<[NewsArticle]>{
        return Observable.create{ observer -> Disposable in
         
            let date = Date().toString()
            let urlString = "https://newsapi.org/v2/everything?q=Apple&from=\(date)8&sortBy=popularity&apiKey=d6734920e71d413b9a73a1dd694ed445"

            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: NewsArticleResponse.self){ response in
                    if let error = response.error{
                        
                        observer.onError(error)
                    }
                    if let articles = response.value?.articles{
                        observer.onNext(articles)
                    }
                    observer.onCompleted()
                }

            return Disposables.create()
        }
    }
    func fetchTeslaArticles() ->Observable<[NewsArticle]>{
        return Observable.create{ observer -> Disposable in
            let date = Date().toString()
            let urlString = "https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=d6734920e71d413b9a73a1dd694ed445"

            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: NewsArticleResponse.self){ response in
                    if let error = response.error{
                        print("tesla")
                        observer.onError(error)
                    }
                    if let articles = response.value?.articles{
                        observer.onNext(articles)
                    }
                    observer.onCompleted()
                }

            return Disposables.create()
        }
    }
    func fetchBitcoinArticles() ->Observable<[NewsArticle]>{
        return Observable.create{ observer -> Disposable in
            let date = Date().toString()
            let urlString = "https://newsapi.org/v2/everything?q=bitcoin&from=\(date)&sortBy=publishedAt&apiKey=d6734920e71d413b9a73a1dd694ed445"

            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: NewsArticleResponse.self){ response in
                    if let error = response.error{
                        print("coin")
                        observer.onError(error)
                    }
                    if let articles = response.value?.articles{
                        observer.onNext(articles)
                    }
                    observer.onCompleted()
                }

            return Disposables.create()
        }
    }
    func fetchBusinessArticles() ->Observable<[NewsArticle]>{
        return Observable.create{ observer -> Disposable in
            let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d6734920e71d413b9a73a1dd694ed445"

            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: NewsArticleResponse.self){ response in
                    if let error = response.error{
                        print("busi")
                        observer.onError(error)
                    }
                    if let articles = response.value?.articles{
                        observer.onNext(articles)
                    }
                    observer.onCompleted()
                }

            return Disposables.create()
        }
    }
    func fetchTechcrunchArticles() ->Observable<[NewsArticle]>{
        return Observable.create{ observer -> Disposable in
            let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d6734920e71d413b9a73a1dd694ed445"

            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: NewsArticleResponse.self){ response in
                    if let error = response.error{
                        print("tech")
                        observer.onError(error)
                    }
                    if let articles = response.value?.articles{
                        observer.onNext(articles)
                    }
                    observer.onCompleted()
                }

            return Disposables.create()
        }
    }
    func searchArticles(searchWord: String) ->Observable<[NewsArticle]>{
        return Observable.create{ observer -> Disposable in
            let date = Date().toString()
            let urlString = "https://newsapi.org/v2/everything?from=\(date)&sortBy=popularity&apiKey=d6734920e71d413b9a73a1dd694ed445&q=\(searchWord)"

            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: NewsArticleResponse.self){ response in
                    if let error = response.error{
                        print("search")
                        observer.onError(error)
                    }
                    if let articles = response.value?.articles{
                        observer.onNext(articles)
                    }
                    observer.onCompleted()
                }

            return Disposables.create()
        }
    }
    
}
