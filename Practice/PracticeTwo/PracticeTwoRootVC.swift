//
//  PracticeTwoRootVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/10.
//

import UIKit
import RxSwift
import RxRelay

class PracticeTwoRootVC: UIViewController {
    
    //MARK : Properties
    let disposeBag = DisposeBag()
    let viewModel : RootViewModel
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver:Observable<[ArticleViewModel]>{
        return articleViewModel.asObservable()
    }
    
    
    private lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(ArticleCVC.self, forCellWithReuseIdentifier: ArticleCVC.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        return cv
    }()
   
    
    //MARK : Life Cycle
    init(viewModel: RootViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchArticles()
        subscribe()
    }
    
    
    //MARK : Configures
    func configureUI(){
        self.title = self.viewModel.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    //MARK : Helpers
    func fetchArticles(){
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    func subscribe(){
        self.articleViewModelObserver.subscribe(onNext: {articles in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}
 
extension PracticeTwoRootVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCVC.identifier, for: indexPath) as! ArticleCVC
        cell.viewModel.onNext(self.articleViewModel.value[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    
}
