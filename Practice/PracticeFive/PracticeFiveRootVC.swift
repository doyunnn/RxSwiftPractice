//
//  PracticeFiveRootVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import UIKit
import RxSwift
import RxCocoa

class PracticeFiveRootVC: UIViewController {

    //MAKR: Properties
    
    let viewModel = MenuViewModel()
    var disposeBag = DisposeBag()
    
    private let orderButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ORDER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapOrderButton), for: .touchUpInside)
        return button
    }()
    private let tableView = UITableView()
    private let totalPriceView = TotalPriceView()
    
    
    
    
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigure()
        subscribe()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orderButton.frame = CGRect(x: 0, y: view.frame.height+view.frame.origin.y-80, width: view.frame.width, height: 80)
        totalPriceView.frame = CGRect(x: 0, y: orderButton.frame.origin.y-150, width: view.frame.width, height: 150)
        tableView.frame = CGRect(x: -10, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height-view.safeAreaInsets.top-orderButton.frame.height-totalPriceView.frame.height)
    }
    
    
    //MARK : Configure
    func defaultConfigure(){
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        title = "doyun menus"
        
        view.addSubview(orderButton)
        view.addSubview(totalPriceView)
        view.addSubview(tableView)
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.identifier)
    }
    
    func subscribe(){
        // TableView
        viewModel.menuObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableViewCell.identifier,
                                         cellType: OrderTableViewCell.self)){ index, item, cell in
                
                cell.selectionStyle = .none
                cell.configure(with: item)
                cell.onChange = { [weak self] state in
                    self?.viewModel.changeCount(item: item, state: state)
                }
            }.disposed(by: disposeBag)
        // TotalCntLabel
        viewModel.itemsCnt
            .map{"Items \($0)"}
            .asDriver(onErrorJustReturn: "")
            .drive(totalPriceView.totalCnt.rx.text)
            .disposed(by: disposeBag)
        //TotalPriceLabel
        viewModel.totalPrice
            .map{"\($0) 원"}
            .observe(on: MainScheduler.instance)
            .bind(to: totalPriceView.totalPriceLabel.rx.text)
            .disposed(by: disposeBag)
        
        
//            .catchAndReturn("")
//            .observe(on: MainScheduler.instance) -> asDriver()
//            .bind(to: totalPriceView.totalCnt.rx.text)  -> drive()
        
        //            .subscribe(onNext: {
        //                self.totalPriceView.totalCnt.text = "\($0)"
        //            }) - > bind()
    }
    
    
    //MARK : Helpers
    func didTapClear(){
        totalPriceView.onClear = { [weak self] in
            self?.viewModel.didTapclear()
        }
    }
    @objc func didTapOrderButton(){
     
    }

   

}
