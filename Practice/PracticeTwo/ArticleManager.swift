//
//  ArticleManager.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleManagerProtocol{
    func fetchNews() -> Observable<[Article]>
}

class ArticleManager: ArticleManagerProtocol{
    func fetchNews() -> Observable<[Article]>{
        return Observable.create{ (observer) -> Disposable in
            self.fetchNews{ (error, articles) in
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
    
    
    private func fetchNews(completion: @escaping((Error?, [Article]?) -> Void)){
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2022-01-09&to=2022-01-09&sortBy=popularity&apiKey=d6734920e71d413b9a73a1dd694ed445"
        guard let url = URL(string: urlString) else {
            return completion(NSError(domain: "doyun", code: 404, userInfo: nil),nil)
        }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseDecodable(of: ArticleResponse.self){ response in
                if let error = response.error{
                    return completion(error,nil)
                }
                if let articles = response.value?.articles{
                    return completion(nil,articles)
                }
            }
        
    }
}
