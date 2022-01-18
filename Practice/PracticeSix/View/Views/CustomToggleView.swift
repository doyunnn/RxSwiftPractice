//
//  CustomToggleView.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//


import UIKit

protocol CustomToggleViewDelegate : AnyObject{
    func item1ButtonTaped()
    func item2ButtonTaped()
    func item3ButtonTaped()
    func item4ButtonTaped()
    func item5ButtonTaped()
}

class CustomToggleView: UIView {

    enum State {
        case item1
        case item2
        case item3
        case item4
        case item5
    }
    
    // MARK: - Properties
    var state: State = .item1
    var buttons : Array<UIButton> = []
    weak var delegate : CustomToggleViewDelegate?
    
    lazy var button1: UIButton = {
       let button = UIButton()
        button.setTitle("Apple", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(didTapItem1), for: .touchUpInside)
        
        return button
    }()
    lazy var button2: UIButton = {
       let button = UIButton()
        button.setTitle("Tesla", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(didTapItem2), for: .touchUpInside)
        
        return button
    }()
    lazy var button3: UIButton = {
       let button = UIButton()
        button.setTitle("Bitcoin", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(didTapItem3), for: .touchUpInside)
        
        return button
    }()
    lazy var button4: UIButton = {
       let button = UIButton()
        button.setTitle("Business", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(didTapItem4), for: .touchUpInside)
        
        return button
    }()
    lazy var button5: UIButton = {
       let button = UIButton()
        button.setTitle("Tech", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(didTapItem5), for: .touchUpInside)

        return button
    }()
    
    private let indicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 0
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(button4)
        addSubview(button5)
        addSubview(indicatorView)
        buttons = [button1,button2,button3,button4,button5]
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonHeight: CGFloat = 30
        button1.frame = CGRect(x: 0, y: 0, width: self.frame.size.width/5, height: buttonHeight)
        button2.frame = CGRect(x: button1.right, y: 0, width: self.frame.size.width/5, height: buttonHeight)
        button3.frame = CGRect(x: button2.right, y: 0, width: self.frame.size.width/5, height: buttonHeight)
        button4.frame = CGRect(x: button3.right, y: 0, width: self.frame.size.width/5, height: buttonHeight)
        button5.frame = CGRect(x: button4.right, y: 0, width: self.frame.size.width/5, height: buttonHeight)
        indicatorView.frame = CGRect(x: 0, y: button1.bottom, width: button1.width, height: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapItem1(_ sender : UIButton){
        delegate?.item1ButtonTaped()
        update(for: .item1,sender:sender)
    }
    @objc func didTapItem2(_ sender : UIButton){
        delegate?.item2ButtonTaped()
        update(for: .item2,sender:sender)
    }
    @objc func didTapItem3(_ sender : UIButton){
        delegate?.item3ButtonTaped()
        update(for: .item3,sender:sender)
   }
    @objc func didTapItem4(_ sender : UIButton){
        delegate?.item4ButtonTaped()
        update(for: .item4,sender:sender)
    }
    @objc func didTapItem5(_ sender : UIButton){
        delegate?.item5ButtonTaped()
        update(for: .item5,sender:sender)
    }
    func layoutIndicator(){
        let indicatorHegiht: CGFloat = 3
        
        switch state {
        case .item1:
            indicatorView.frame  = CGRect(x: 0, y: button1.bottom, width: button1.width, height: indicatorHegiht)
        case .item2 :
            indicatorView.frame  = CGRect(x: button1.right, y: button2.bottom, width: button2.width, height: indicatorHegiht)
        case .item3 :
            indicatorView.frame  = CGRect(x: button2.right, y: button3.bottom, width: button3.width, height: indicatorHegiht)

        case .item4 :
            indicatorView.frame  = CGRect(x: button3.right, y: button4.bottom, width: button4.width, height: indicatorHegiht)
        case .item5 :
            indicatorView.frame  = CGRect(x: button4.right, y: button5.bottom, width: button5.width, height: indicatorHegiht)
        }
    }
    
    func update(for state: State,sender : UIButton){
        self.state = state
        self.changeButtonColor(sender: sender)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        
        }
        
    }
    func changeButtonColor(sender: UIButton) {
        DispatchQueue.main.async {
            for button in self.buttons{
                if sender == button {
                    // tapped button
                    button.setTitleColor(.black, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                }else {
                    button.setTitleColor(.gray, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                }
            }
        }
        
    }

}
