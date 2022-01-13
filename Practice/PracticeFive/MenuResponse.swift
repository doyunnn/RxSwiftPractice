//
//  MenuModel.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import Foundation
struct MenuResponse:Codable{
    let menus : [MenuItem]
}
struct MenuItem:Codable{
    let name : String
    let price : Int
}
