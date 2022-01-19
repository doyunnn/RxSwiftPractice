//
//  SearchVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import UIKit
import RxSwift
import RxCocoa
class SearchVC: UIViewController {
    
    //MARK : Properties
    var viewModel = SearchArticlesViewModel()
    let disposeBag = DisposeBag()
    
    private let searchView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private let searchBar : UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let image : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass")
        view.tintColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let line : UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cancelButton : UIButton = {
       let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchField : UITextField = {
       let field = UITextField()
        field.placeholder = "검색..."
        field.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        field.tintColor = .darkGray
        field.textColor = UIColor.black
        field.backgroundColor = .clear
        field.leftViewMode = .always
        field.borderStyle = .none
        field.returnKeyType = .search
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let tableView : UITableView = {
       let view = UITableView()
        view.register(NewsTableviewCell.self, forCellReuseIdentifier: NewsTableviewCell.identifier)
        view.backgroundColor = .white
        view.tableFooterView = UIView(frame: .zero)
        view.sectionFooterHeight = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detaultConfigure()
        subscribe()
    }
       
    //MARK : Congfigure
    func detaultConfigure(){
        view.backgroundColor = .white
        self.dismissKeyboardWhenTappedAround()
        view.addSubview(searchView)
        view.addSubview(tableView)
   
        
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        searchView.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: searchView.leftAnchor,constant: 20).isActive = true
        searchBar.rightAnchor.constraint(equalTo: searchView.rightAnchor,constant: -20).isActive = true
        searchBar.topAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor,constant: -10).isActive = true
        
        searchBar.addSubview(image)
        image.leftAnchor.constraint(equalTo: searchBar.leftAnchor,constant: 15).isActive = true
        image.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 18).isActive = true
        image.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        searchBar.addSubview(line)
        line.leftAnchor.constraint(equalTo: image.rightAnchor,constant: 10).isActive = true
        line.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        line.widthAnchor.constraint(equalToConstant: 1).isActive = true
        line.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        searchBar.addSubview(cancelButton)
        cancelButton.rightAnchor.constraint(equalTo: searchBar.rightAnchor,constant: -5).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        searchBar.addSubview(searchField)
        searchField.leftAnchor.constraint(equalTo: line.rightAnchor,constant: 10).isActive = true
        searchField.rightAnchor.constraint(equalTo: cancelButton.leftAnchor,constant: -10).isActive = true
        searchField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func subscribe(){
        viewModel.searchObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: NewsTableviewCell.identifier, cellType: NewsTableviewCell.self)){ index, item, cell in

                cell.configure(with: item)
            }.disposed(by: disposeBag)
        searchField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { _ in
                print(self.searchField.text ?? "")
                
            }).disposed(by: disposeBag)
    }
    //MARK : Helpers
    @objc func didTapCancelButton(){
        self.dismiss(animated: true, completion: nil)
    }
    func ser(){
        self.searchField.rx.text
            .orEmpty
            .subscribe(onNext: { text in
                
                print(text)
                self.viewModel.search(searchWord: text)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}

