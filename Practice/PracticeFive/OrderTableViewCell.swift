//
//  TableViewCell.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import UIKit
class OrderTableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"

    
    //MARK : Properties
    private let plusButton : UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private let minusButton : UIButton = {
       let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
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
        addSubview(plusButton)
        addSubview(minusButton)
        addSubview(menuNameLabel)
        addSubview(countLabel)
        addSubview(priceLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        plusButton.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        minusButton.frame = CGRect(x: plusButton.frame.width+plusButton.frame.origin.x, y: 0, width: 50, height: 50)
        menuNameLabel.frame = CGRect(x: minusButton.frame.width+minusButton.frame.origin.x, y: 0, width: 60, height: 50)
        countLabel.frame = CGRect(x: menuNameLabel.frame.width+menuNameLabel.frame.origin.x, y: 0, width: 30, height: 50)
        priceLabel.frame = CGRect(x: self.frame.width+self.frame.origin.x-100, y: 0, width: 100, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
