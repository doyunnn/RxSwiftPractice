//
//  MenuViewModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/13.
//

import Foundation
import RxSwift
import RxCocoa
class MenuViewModel {
    var menuObservable = BehaviorRelay<[Menu]>(value: [])
    
    lazy var itemsCnt = menuObservable.map {
        $0.map{ $0.count }.reduce(0,+)
    }
    lazy var totalPrice = menuObservable.map {
        $0.map{ $0.price * $0.count }.reduce(0,+)
    }
    
    init(){
       _ = MenuManager.shared.fetchMenuItem()
            .map{ menuitems -> [Menu] in
                var menus = [Menu]()
                menuitems.enumerated().forEach{ index, item in
                    menus.append(Menu.fromMenuItems(id: index, item: item))
                }
                return menus
            }
            .take(1)
            .bind(to: menuObservable)
    }
    
    func didTapclear(){
        _ = menuObservable
            .observe(on: MainScheduler.instance)
            .map{ menus in
                menus.map{ m in
                    Menu(id: m.id, name: m.name, price: m.price, count: 0)
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.menuObservable.accept($0)
                })
    }
    func changeCount(item : Menu, state: Int){
        menuObservable
            .map{ menus in
                menus.map{
                    if $0.id == item.id{
                        return Menu(id: $0.id, name: $0.name, price: $0.price, count: max(item.count + state, 0))
                    }else{
                        return Menu(id: $0.id, name: $0.name, price: $0.price, count: $0.count)
                    }
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.menuObservable.accept($0)
            })
    }
    
    
  

}
