//
//  MenuModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/13.
//

import Foundation

struct Menu:Codable{
    let id : Int
    let name : String
    let price : Int
    let count : Int
}
extension Menu{
    static func fromMenuItems(id: Int, item: MenuItem)->Menu{
        return Menu(id: id, name: item.name, price: item.price, count: 0)
        
    }
}
