//
//  ArticleVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//

import UIKit
import RxSwift

class ArticleVC: UIViewController {
    //MAKR : Properties
    
    let viewModel : NewsViewModel
    let index : Int
    
    var disposeBag = DisposeBag()
    
    init(viewModel : NewsViewModel, index : Int){
        self.viewModel = viewModel
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView : UITableView = {
       let view = UITableView()
        view.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        view.separatorStyle = .none
        view.tableFooterView = UIView(frame: .zero)
        view.sectionFooterHeight = 0
        return view
    }()
    private let headerView : ArticleStretchyHeaderView = {
       let view = ArticleStretchyHeaderView()
        view.sizeToFit()
        view.backgroundColor = .blue
        return view
    }()
    lazy var barButton : UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: ""), style: .done, target: self, action: #selector(didTapBackButton))
        barButton.image = UIImage(systemName: "chevron.backward.circle.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 20,weight: .bold))
        barButton.imageInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
        barButton.tintColor = .lightGray
        return barButton
    }()
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        subscribe()
    }
    
    
    //MARK : Configure
    func configure(){
        self.setInitNavigationBar()
        self.navigationItem.leftBarButtonItem = barButton
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: 300)
        
     
    }
    func subscribe(){
        viewModel.newsObservable
            .observe(on: MainScheduler.instance)
            .map{[$0[self.index]]}
            .bind(to: tableView.rx.items(cellIdentifier: ArticleTableViewCell.identifier, cellType: ArticleTableViewCell.self)){ index, item, cell in
                guard let image = item.urlToImage else{
                    return
                }
                self.headerView.headerView.setImage(with: image)
                cell.configure(with: item)
                cell.onBookMark = {
                    self.viewModel.didTapBookMark()
                }
            }.disposed(by: disposeBag)
        
        self.tableView.rx.didScroll
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                guard let header = self.tableView.tableHeaderView as? ArticleStretchyHeaderView else {
                    return
                }
                header.scrollViewDidScroll(scrollView: self.tableView)
            }).disposed(by: disposeBag)
    }
    
    // MARK : Hekpers
    
    @objc func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }

}
