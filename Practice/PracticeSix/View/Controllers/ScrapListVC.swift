//
//  BookMarkListVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import UIKit
import RxSwift

class ScrapListVC: UIViewController {

    //MARK : Properties
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    lazy var tableView : UITableView = {
       let view = UITableView()
        view.separatorStyle = .none
        view.register(ScrapTableViewCell.self, forCellReuseIdentifier: ScrapTableViewCell.identifier)
        view.backgroundColor = .white
        view.sectionFooterHeight = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dafaultConfigure()
        subscribe()
    }
    
    //MARK : Configure
    func dafaultConfigure(){
        navigationController?.navigationBar.tintColor = .black
        title = "BookMarkList"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func subscribe(){
        viewModel.scrapObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: ScrapTableViewCell.identifier, cellType: ScrapTableViewCell.self)){ index, item, cell in
                cell.viewModel.onNext(self.viewModel.scrapObservable.value[index])
                cell.onDelete = {
                    self.viewModel.deleteScrapArticle(article: item, self)
                }
            }.disposed(by: disposeBag)
        
    }
    
    //MAKR : Helpers


}
