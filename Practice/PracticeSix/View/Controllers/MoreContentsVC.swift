//
//  MoreContentsVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa

class MoreContentsVC: UIViewController {
    
    //MARK : Properties
    let viewModel = NewsViewModel()
    let disposeBag = DisposeBag()
    
    let sectionTitles = ["Apple","Tesla","Bitcoin","Business","Tech"]
    
    private let topToggleView : CustomToggleView = {
       let view = CustomToggleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftBarButton : UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: ""), style: .done, target: self, action: #selector(didTapBackButton))
        barButton.image = UIImage(systemName: "chevron.backward",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .medium))
        barButton.imageInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        barButton.tintColor = .lightGray
        return barButton
    }()
    lazy var rightBarButton : UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: ""), style: .done, target: self, action: #selector(didTapSearchButton))
        barButton.image = UIImage(systemName: "magnifyingglass",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16,weight: .medium))
        barButton.tintColor = .black
        return barButton
    }()
    
    private let tableView : UITableView = {
       let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.register(NewsTableviewCell.self, forCellReuseIdentifier: NewsTableviewCell.identifier)
        view.backgroundColor = .white
        view.sectionFooterHeight = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigure()
   
        subscribe()
//        fetchData()
    }
    
    
    //MARK : Configure
    func defaultConfigure(){
        self.setInitNavigationBar()
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        view.backgroundColor = .white
        
        view.addSubview(topToggleView)
        topToggleView.delegate = self
        topToggleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topToggleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topToggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topToggleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = nil
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topToggleView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func subscribe(){
        viewModel.appleNewsObservable.asObservable()
            .subscribe(onNext: { _ in
                self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
            }).disposed(by: disposeBag)
        
        viewModel.teslaNewsObservable.asObservable()
            .subscribe(onNext: { _ in
                self.tableView.reloadSections(IndexSet(1...1), with: .automatic)
            }).disposed(by: disposeBag)
        viewModel.bitcoinNewsObservable.asObservable()
            .subscribe(onNext: { _ in
                self.tableView.reloadSections(IndexSet(2...2), with: .automatic)
            }).disposed(by: disposeBag)
        viewModel.businessNewsObservable.asObservable()
            .subscribe(onNext: { _ in
                self.tableView.reloadSections(IndexSet(3...3), with: .automatic)
            }).disposed(by: disposeBag)
        viewModel.techNewsObservable.asObservable()
            .subscribe(onNext: { _ in
                self.tableView.reloadSections(IndexSet(4...4), with: .automatic)
            }).disposed(by: disposeBag)

      
    }
    //MARK : Helpers
    @objc func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func didTapSearchButton(){
        let vc = SearchVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }

}
extension MoreContentsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return viewModel.appleNewsObservable.value.count
        case 1:
            return viewModel.teslaNewsObservable.value.count
        case 2:
            return viewModel.bitcoinNewsObservable.value.count
        case 3:
            return viewModel.businessNewsObservable.value.count
        case 4:
            return viewModel.techNewsObservable.value.count
        default : return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableviewCell.identifier, for: indexPath) as! NewsTableviewCell
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:
            configureCellArticles(observableValue: self.viewModel.appleNewsObservable.value[indexPath.row], cell: cell)
        case 1:
            configureCellArticles(observableValue: self.viewModel.teslaNewsObservable.value[indexPath.row], cell: cell)
        case 2:
            configureCellArticles(observableValue: self.viewModel.bitcoinNewsObservable.value[indexPath.row], cell: cell)
        case 3:
            configureCellArticles(observableValue: self.viewModel.businessNewsObservable.value[indexPath.row], cell: cell)
        case 4:
            configureCellArticles(observableValue: self.viewModel.techNewsObservable.value[indexPath.row], cell: cell)
        default : break
        }
        return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = ArticleVC(newsViewModel: viewModel,section: indexPath.section, index: indexPath.row) else{
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 54))
        let label = UILabel(frame: CGRect(x: 16, y: 16, width: view.width-32, height: 28))
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 30)
        label.text = sectionTitles[section]
        header.addSubview(label)
        header.backgroundColor = .white
        return header
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < (tableView.rectForRow(at: IndexPath(row: 0, section: 1)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40){
            topToggleView.update(for: .item1, sender: topToggleView.button1)
        }else if scrollView.contentOffset.y >= (tableView.rectForRow(at: IndexPath(row: 0, section: 1)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40) && scrollView.contentOffset.y < (tableView.rectForRow(at: IndexPath(row: 0, section: 2)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40){
            topToggleView.update(for: .item2, sender: topToggleView.button2)
        }else if scrollView.contentOffset.y >= (tableView.rectForRow(at: IndexPath(row: 0, section: 2)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40) && scrollView.contentOffset.y < (tableView.rectForRow(at: IndexPath(row: 0, section: 3)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40){
            topToggleView.update(for: .item3, sender: topToggleView.button3)
        }else  if scrollView.contentOffset.y >= (tableView.rectForRow(at: IndexPath(row: 0, section: 3)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40) && scrollView.contentOffset.y < (tableView.rectForRow(at: IndexPath(row: 0, section:4)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40){
            topToggleView.update(for: .item4, sender: topToggleView.button4)
        }else  if scrollView.contentOffset.y >= (tableView.rectForRow(at: IndexPath(row: 0, section: 4)).origin.y-CGFloat((navigationController?.navigationBar.frame.height)!)-40) {
            topToggleView.update(for: .item5, sender: topToggleView.button5)
        }

    }
    func configureCellArticles(observableValue: NewsArticle,cell : NewsTableviewCell){
        cell.viewModel.onNext(observableValue)
        cell.onScrap = {
            self.viewModel.didTapScrap(article: observableValue, self)
        }
    }
}
extension MoreContentsVC : CustomToggleViewDelegate {
    func item1ButtonTaped() {
        viewModel.didTapApple(tableView: tableView)
    }
    
    func item2ButtonTaped() {
        viewModel.didTapTesla(tableView: tableView)
    }
    
    func item3ButtonTaped() {
        viewModel.didTapBitcoin(tableView: tableView)
    }
    
    func item4ButtonTaped() {
        viewModel.didTapBusiness(tableView: tableView)
    }
    
    func item5ButtonTaped() {
        viewModel.didTapTech(tableView: tableView)
    }
    
    
}
