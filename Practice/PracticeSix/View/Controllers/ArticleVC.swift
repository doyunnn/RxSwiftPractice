//
//  ArticleVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa
class ArticleVC: UIViewController {
    //MAKR : Properties
    
    var headLineViewModel : HeadLineNewsViewModel?
    var newsViewModel : NewsViewModel?
    let index : Int
    var section : Int?
    
    var disposeBag = DisposeBag()
    
    init?(headLineViewModel : HeadLineNewsViewModel, index : Int) {
        self.headLineViewModel = headLineViewModel
        self.index = index
        super.init(nibName: nil, bundle: nil)
        
    }
    init?(newsViewModel: NewsViewModel, section : Int, index : Int) {
       
        self.index = index
        self.newsViewModel = newsViewModel
        self.section = section
        super.init(nibName: nil, bundle: nil)
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView : UITableView = {
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
    lazy var leftBbarButton : UIBarButtonItem = {
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
        self.navigationItem.leftBarButtonItem = leftBbarButton

        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: 300)
        
     
    }
    func subscribe(){
        
        if let headLineViewModel = headLineViewModel {
            bindTableView(observable: headLineViewModel.headLineNewsObservable)
            
        }else if let newsViewModel = newsViewModel{
            guard let section = section else {
                return
            }
            switch section {
            case 0 :
                bindTableView(observable: newsViewModel.appleNewsObservable)
                break
            case 1:
                bindTableView(observable: newsViewModel.teslaNewsObservable)
                break
            case 2:
                bindTableView(observable: newsViewModel.bitcoinNewsObservable)
                break
            case 3:
                bindTableView(observable: newsViewModel.businessNewsObservable)
                break
            case 4:
                bindTableView(observable: newsViewModel.techNewsObservable)
                break
            default: break
            }
          
        }
        self.tableView.rx.didScroll
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let header = self?.tableView.tableHeaderView as? ArticleStretchyHeaderView else {
                    return
                }
                header.scrollViewDidScroll(scrollView: self!.tableView)
            }).disposed(by: disposeBag)
        
    }
    
    // MARK : Hekpers
    
    @objc func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }

    func bindTableView(observable : BehaviorRelay<[NewsArticle]>){
        observable
            .observe(on: MainScheduler.instance)
            .map{[$0[self.index]]}
            .bind(to: tableView.rx.items(cellIdentifier: ArticleTableViewCell.identifier, cellType: ArticleTableViewCell.self)){ index, item, cell in
                guard let image = item.urlToImage else{
                    return
                }
                self.headerView.headerView.setImage(with: image)
                cell.configure(with: item)
                cell.onScrap = {
                    self.headLineViewModel?.didTapScrap(article: item,self)
                    self.newsViewModel?.didTapScrap(article: item,self)
                    
                }
            }.disposed(by: disposeBag)
    }
}
