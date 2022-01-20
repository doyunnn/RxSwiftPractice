//
//  DatabaseManager.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/20.
//

import Foundation
import FirebaseFirestore


final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let databese = Firestore.firestore()
    
    private init(){}
    //MARK : Post & User
    public func insert(with article: NewsArticle,email: String, completion: @escaping (Bool)->Void){
        let userEamil = email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        let id = UUID().uuidString
        let data : [String : Any] = [
//            "source" : article.source,
            "id" : id,
            "author" : article.author ?? "",
            "title" : article.title ?? "",
            "articleDescription" : article.articleDescription ?? "",
            "url" : article.url,
            "urlToImage" : article.urlToImage ?? "",
            "publishedAt" : article.publishedAt ,
            "content" : article.content ?? "",
            
        ]
        databese
            .collection("users")
            .document(userEamil)
            .collection("scraps")
            .document(id)
            .setData(data){error in
                completion(error == nil)
                
            }
    }
    public func getScrapArticles(for email: String, completion: @escaping ([ScrapArticle])->Void){
        let userEamil = email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        databese
            .collection("users")
            .document(userEamil)
            .collection("scraps")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents.compactMap({$0.data()}),
                      error == nil else{
                          print("document error")
                          return
                      }
                
                let ScrapArticles : [ScrapArticle] = documents.compactMap({dictionary in
                    guard let id = dictionary["id"] as? String,
                          let author = dictionary["author"] as? String,
                          let title = dictionary["title"] as? String,
                          let articleDescription = dictionary["articleDescription"] as? String,
                          let url = dictionary["url"] as? String,
                          let urlToImage = dictionary["urlToImage"] as? String,
                          let publishedAt = dictionary["publishedAt"] as? String,
                          let content = dictionary["content"] as? String else{
                              print("dictionary error")
                              return nil
                          }
                    
                    
                    let scrapArticle = ScrapArticle(id: id, author: author, title: title, articleDescription: articleDescription, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
                    return scrapArticle
                })
                completion(ScrapArticles)
            }
    }
    public func deleteScrapArticle(email: String,id:String,completion: @escaping(Bool)->Void){
        let documentId = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        let ref = databese
            .collection("users")
            .document(documentId)
            .collection("scraps")
            .document(id)
        ref.delete { error in
            completion(error == nil)
        }
  
    }
}
