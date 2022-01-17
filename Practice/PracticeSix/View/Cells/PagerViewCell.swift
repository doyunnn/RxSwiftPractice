//
//  PagerViewCell.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import UIKit
import RxSwift
import FSPagerView
class PagerViewCell: FSPagerViewCell{
    static let identifier = "PagerViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy var image : UIImageView = {
       let view = UIImageView()

        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var author : UILabel = {
       let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var title : UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var publishedAt : UILabel = {
       let label = UILabel()

        label.textColor = .gray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(author)
        addSubview(title)
        addSubview(publishedAt)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding : CGFloat = 15
        image.leftAnchor.constraint(equalTo: self.leftAnchor,constant: padding).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -padding).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor,constant: padding).isActive = true
        image.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        author.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 20).isActive = true
        author.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        title.topAnchor.constraint(equalTo: author.bottomAnchor,constant: 10).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor,constant: padding).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -padding).isActive = true
        
        publishedAt.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 10).isActive = true
        publishedAt.leftAnchor.constraint(equalTo: self.leftAnchor,constant: padding).isActive = true
        publishedAt.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel : NewsViewModel,index : Int){
        viewModel.newsObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] articles in
            guard let urlToImage = articles[index].urlToImage,
                  let author = articles[index].author,
                  let title = articles[index].title,
                  let publishedAt = articles[index].publishedAt else{
                return
            }
            self?.image.setImage(with: urlToImage)
            self?.author.text = author
            self?.title.text = title
            self?.publishedAt.text = publishedAt
            
        }).disposed(by: disposeBag)
    }
    
}
