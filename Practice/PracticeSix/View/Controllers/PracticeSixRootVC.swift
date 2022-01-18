//
//  PracticeSixRootVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView
class PracticeSixRootVC: UIViewController {

    //MARK : Properties
    let viewModel = NewsViewModel()
    let disposeBag = DisposeBag()
    
    private var modelCnt = 0
    
    lazy var naviView : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let moreButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 82, height: 0))
        button.setImage(UIImage(systemName: "chevron.right",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16,weight: .bold)), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: 72, bottom: 0, right: 0)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("더 보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    lazy var profileBarButton : UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(didTapProfileButton))
        barButton.tintColor = .black
        return barButton
    }()
    private let topView : UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bottomView : UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let pagerView : FSPagerView = {
        let view = FSPagerView()
        view.itemSize = CGSize(width: 280, height: 520)
        view.transformer = FSPagerViewTransformer(type: .linear)
        view.register(PagerViewCell.self, forCellWithReuseIdentifier: PagerViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.gradientLayerColors = [UIColor.clear.withAlphaComponent(0.01), .white]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigure()
        subscribe()
    
    }
    
    //MARK : Configure
    func defaultConfigure(){
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        title = "Headline News"
        moreButton.addTarget(self, action: #selector(didTapMoreContentsButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
        navigationItem.leftBarButtonItem = profileBarButton
        

        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(bottomView)
        bottomView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(pagerView)
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        pagerView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        pagerView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        pagerView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor,constant: -10).isActive = true

        topView.addSubview(gradientView)
        gradientView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: topView.rightAnchor).isActive = true
     
    }
    func subscribe(){

        
        viewModel.newsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] articles in
                guard let image = articles.first?.urlToImage else{
                    return
                }
                self?.pagerView.reloadData()
                self?.modelCnt = articles.count
                self?.topView.setImage(with: image)
            }).disposed(by: disposeBag)

    }
    
    //MARK : Helpers
    @objc func didTapProfileButton(){
        
    }
    @objc func didTapMoreContentsButton(){
        
    }
}
//MARK: - FSPagerViewDelegate
extension PracticeSixRootVC : FSPagerViewDelegate, FSPagerViewDataSource{

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelCnt
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: PagerViewCell.identifier, at: index) as! PagerViewCell
        cell.layer.cornerRadius = 25
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        cell.configure(with: self.viewModel,index: index)
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        let vc = ArticleVC(viewModel: viewModel, index: index)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        viewModel.newsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] articles in
                guard let image = articles[targetIndex].urlToImage else{
                    return
                }
                self?.topView.setImage(with: image)
            }).disposed(by: disposeBag)

    }
}
