//
//  TableViewCell.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import UIKit
import RxSwift
import RxCocoa
class OrderTableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"

    
    //MARK : Properties
    
    var onChange : ((Int)->Void)?
    var disposeBag = DisposeBag()
    
    lazy var plusButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        return button
    }()
    lazy var minusButton : UIButton = {
       let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        return button
    }()
    lazy var menuNameLabel : UILabel = {
       let label = UILabel()
        label.text = "Menu"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var countLabel : UILabel = {
       let label = UILabel()
        label.text = "(0)"
        return label
    }()
    lazy var priceLabel : UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    //MARK : Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(plusButton)
        contentView.addSubview(minusButton)
        addSubview(menuNameLabel)
        addSubview(countLabel)
        addSubview(priceLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        plusButton.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        minusButton.frame = CGRect(x: plusButton.frame.width+plusButton.frame.origin.x, y: 0, width: 50, height: 50)
        menuNameLabel.frame = CGRect(x: minusButton.frame.width+minusButton.frame.origin.x, y: 0, width: 100, height: 50)
        countLabel.frame = CGRect(x: menuNameLabel.frame.width+menuNameLabel.frame.origin.x, y: 0, width: 30, height: 50)
        priceLabel.frame = CGRect(x: self.frame.width+self.frame.origin.x-100, y: 0, width: 100, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    //Helpers
    @objc func didTapPlus(_ sender : UIButton){
        onChange?(+1)
    }
    @objc func didTapMinus(){
        onChange?(-1)
    }
}

