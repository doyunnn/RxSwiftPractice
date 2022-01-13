//
//  MenuViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/13.
//

import Foundation
import RxSwift
class MenuViewModel {
    var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
    lazy var itemsCnt = menuObservable.map {
        $0.map{ $0.count }.reduce(0,+)
    }
    lazy var totalPrice = menuObservable.map {
        $0.map{ $0.price + $0.count }.reduce(0,+)
    }
    
    init(){
        let menus: [Menu] = [
            Menu(id: 0, name: "감자튀김", price: 100, count: 0),
            Menu(id: 1, name: "감자튀김", price: 100, count: 0),
            Menu(id: 2, name: "감자튀김", price: 100, count: 0),
            Menu(id: 3, name: "감자튀김", price: 100, count: 0),
            Menu(id: 4, name: "감자튀김", price: 100, count: 0)
        ]
        menuObservable.onNext(menus)
    }
    
    
  

}
