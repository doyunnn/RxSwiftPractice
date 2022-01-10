//
//  RxTestOneVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import UIKit
import RxSwift
import RxCocoa

struct Product{
    let imageName : String
    let title : String
}
struct ProductViewModel {
     var items = PublishSubject<[Product]>()
    
    func fetchItmes(){
        let products = [
            Product(imageName: "house", title: "home"),
            Product(imageName: "car", title: "car"),
            Product(imageName: "bell", title: "bell"),
            Product(imageName: "house", title: "home"),
            Product(imageName: "car", title: "car"),
            Product(imageName: "bell", title: "bell"),
            Product(imageName: "house", title: "home"),
            Product(imageName: "car", title: "car"),
            Product(imageName: "bell", title: "bell"),
            Product(imageName: "house", title: "home"),
            Product(imageName: "car", title: "car"),
            Product(imageName: "bell", title: "bell"),
            
        ]
        items.onNext(products)
        items.onCompleted()
    }
}

class RxTestOneVC: UIViewController {
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var viewmodel = ProductViewModel()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
    }
    func bindTableData(){
        // 테이블뷰
        viewmodel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)){
                    row, model, cell in
                    cell.textLabel?.text = model.title
                    cell.imageView?.image = UIImage(systemName: model.imageName)
                }.disposed(by: bag)
        // cell 선택
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
        }.disposed(by: bag)
        
        viewmodel.fetchItmes()
        print("test")
    }
    

}
