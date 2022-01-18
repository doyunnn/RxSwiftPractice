//
//  ArticleTableViewCell.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    //MARK : Propertise
    static let identifier = "ArticleTableViewCell"
    
    var onBookMark : (()->Void)?
    
    lazy var sourceName : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var author : UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var title : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var content : UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
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
   
    private let line : UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bookMark : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18,weight: .medium)), for: .normal)
        button.tintColor = .purple
        button.addTarget(self, action: #selector(didTapBookMarkButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK : Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : Configre
    func defaultConfigure(){
        let padding : CGFloat = 15
        contentView.addSubview(sourceName)
        sourceName.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        sourceName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding).isActive = true
        
        contentView.addSubview(bookMark)
        bookMark.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -5).isActive = true
        bookMark.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0).isActive = true
        bookMark.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bookMark.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(title)
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        title.topAnchor.constraint(equalTo: sourceName.bottomAnchor,constant: 15).isActive = true

        contentView.addSubview(author)
        author.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        author.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 10).isActive = true

        contentView.addSubview(publishedAt)
        publishedAt.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        publishedAt.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 10).isActive = true

        contentView.addSubview(line)
        line.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        line.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        line.topAnchor.constraint(equalTo: author.bottomAnchor,constant: padding).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.6).isActive = true

        contentView.addSubview(content)
        content.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding).isActive = true
        content.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding).isActive = true
        content.topAnchor.constraint(equalTo: line.bottomAnchor,constant: padding).isActive = true
        content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -padding).isActive = true
    }
    
    func configure(with model : NewsArticle){
        sourceName.text = model.source.name
        title.text = model.title
        author.text = model.author
        publishedAt.text = model.publishedAt
        content.text = model.content
    }
    
    //MARK : Helpers
    @objc func didTapBookMarkButton(){
        onBookMark?()
    }
    
}
