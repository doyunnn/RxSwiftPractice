//
//  PracticeFourRootVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import UIKit
import RxSwift

class PracticeFourRootVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        runObservable()
    }
    
    func createObservable() -> Observable<String>{
        // 비동기로 생기는 데이터를 Observable로 감싸서 리턴
//        return Observable.just("Hello RxSwfit") // just hello swift
        return Observable.from(["Hello","Swift"]) // from  - hello \n swift
        
        
        // 풀어서 쓴 코드 
        /*return Observable.create(){ data in
            data.onNext("hello")
            data.onNext("rxswift")
            data.onCompleted()
            return Disposables.create()
        }*/
    }
    
    func runObservable(){
        createObservable()
            .subscribe(onNext: {print($0)})
        
        // 풀어서 쓴 코드
        /* .subscribe{ event in
                switch event {
                case let .next(data):
                    print(data)
                case .completed :
                    break
                case .error :
                    break
                }
            }*/
    }
    


}
