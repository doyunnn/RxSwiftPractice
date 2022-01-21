//
//  ScrapTableViewCell.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/21.
//

import UIKit
import RxSwift
class ScrapTableViewCell: UITableViewCell {
    
    static let identifier = "ScrapTableViewCell"
    var viewModel = PublishSubject<ScrapArticle>()
    var disposeBag = DisposeBag()
    
    var onDelete : (()->Void)?
    
    lazy var contentImage : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var author : UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var title : UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var content : UILabel = { // desciption
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
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
    private let deleteButton : UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK : Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImage.image = nil
        author.text = nil
        title.text = nil
        publishedAt.text = nil
        
    }
    //MARK : configure
    func setConfigure(){
        let padding : CGFloat = 15
        contentView.addSubview(contentImage)
        contentImage.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        contentImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding).isActive = true
        contentImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contentImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        contentView.addSubview(deleteButton)
        deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -15).isActive = true
        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        contentView.addSubview(author)
        author.leftAnchor.constraint(equalTo: contentImage.rightAnchor,constant: 10).isActive = true
        author.rightAnchor.constraint(equalTo: deleteButton.leftAnchor,constant: -padding).isActive = true
        author.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding).isActive = true
        
        contentView.addSubview(title)
        title.leftAnchor.constraint(equalTo: contentImage.rightAnchor,constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        title.topAnchor.constraint(equalTo: author.bottomAnchor,constant: padding).isActive = true
        
        
        contentView.addSubview(publishedAt)
        publishedAt.leftAnchor.constraint(equalTo: contentImage.rightAnchor,constant: 10).isActive = true
        publishedAt.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        publishedAt.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5).isActive = true
        
        contentView.addSubview(content)
        content.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        content.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        content.topAnchor.constraint(equalTo: contentImage.bottomAnchor,constant: 20).isActive = true
        content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -padding).isActive = true
    }
    func subscribe(){
        viewModel
            .subscribe(onNext: { [weak self] article in
                self?.contentImage.setImage(with: article.urlToImage)
                self?.author.text = article.author
                self?.title.text = article.title
                self?.publishedAt.text = article.publishedAt
            }).disposed(by: disposeBag)
    }
    @objc func didTapDeleteButton(){
        onDelete?()
    }
}
