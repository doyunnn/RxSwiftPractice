//
//  PracticeFiveRootVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import UIKit

class PracticeFiveRootVC: UIViewController {

    //MAKR: Properties
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
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        title = "doyun menus"
        
        view.addSubview(orderButton)
        view.addSubview(totalPriceView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: OrderTableViewCell.identifier)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orderButton.frame = CGRect(x: 0, y: view.frame.height+view.frame.origin.y-80, width: view.frame.width, height: 80)
        totalPriceView.frame = CGRect(x: 0, y: orderButton.frame.origin.y-150, width: view.frame.width, height: 150)
        tableView.frame = CGRect(x: -10, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height-view.safeAreaInsets.top-orderButton.frame.height-totalPriceView.frame.height)
    }
    
    
    //MARK : Configure
    
    
    //MARK : Helpers
    func fetchMenus(){
        MenuManager.shared.fetchMenu { error, menus in
            guard let menus = menus else{
                return
            }
            
        }
    }
    @objc func didTapOrderButton(){
        
    }

   

}
extension PracticeFiveRootVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath)
        return cell
    }
    

}
