//
//  MenuModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import Foundation
struct MenuResponse:Codable{
    let menus : [Menu]
}
struct Menu:Codable{
    let name : String
    let price : Int
}
