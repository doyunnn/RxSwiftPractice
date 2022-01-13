//
//  MenuManager.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import Foundation
import Alamofire
import RxSwift
final class MenuManager{
    static let shared = MenuManager()
    init(){}
    
    func fetchMenu(completion: @escaping((Error?, [MenuItem]?) -> Void)){
        let urlString = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
        guard let url = URL(string: urlString) else {
            return completion(NSError(domain: "doyun", code: 404, userInfo: nil),nil)
        }
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseDecodable(of: MenuResponse.self){ response in
                if let error = response.error{
                    return completion(error,nil)
                }
                if let response = response.value{
                    return completion(nil,response.menus)
                }
            }
        
    }
    func fetchMenuItem()->Observable<[MenuItem]>{
        return Observable.create { emitter in
            let urlString = "https://firebasestorage.googleapis.com/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json?alt=media&token=42d5cb7e-8ec4-48f9-bf39-3049e796c936"
            AF.request(urlString,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil)
                .responseDecodable(of: MenuResponse.self){ response in
                    switch response.result{
                    case .success(let response):
                        emitter.onNext(response.menus)
                    case .failure(let error):
                        emitter.onError(error)
                    }
                }
            
            return Disposables.create()
        }
        
    }
    
}
