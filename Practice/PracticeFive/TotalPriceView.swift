//
//  OrderView.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/12.
//

import UIKit

class TotalPriceView: UIView {

    
    //MARK : Properties
    
    var onClear : (()->Void)?
    
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Your Orders"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    lazy var totalCnt : UILabel = {
        let label = UILabel()
        label.text = "items 0"
        label.textColor = .systemPurple
        return label
    }()
    private let clearButton : UIButton = {
       let button = UIButton()
        button.setTitle("clear", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
        return button
    }()
    lazy var totalPriceLabel : UILabel = {
       let label = UILabel()
        label.text = "10000000"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .right
        return label
    }()
    
    
    //MARK : Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview(titleLabel)
        addSubview(totalCnt)
        addSubview(clearButton)
        addSubview(totalPriceLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 20, y: 0, width: 140, height: 50)
        totalCnt.frame = CGRect(x: titleLabel.frame.size.width + titleLabel.frame.origin.x, y: 0, width: 100, height: 50)
        clearButton.frame = CGRect(x: frame.size.width + frame.origin.x-90, y: 0, width: 100, height: 50)
        totalPriceLabel.frame = CGRect(x: -20, y: titleLabel.frame.height+titleLabel.frame.origin.y, width: frame.width, height: 100)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Helpers
    @objc func didTapClear(){
        onClear?()
    }

}
