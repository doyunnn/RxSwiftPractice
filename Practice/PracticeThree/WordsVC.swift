//
//  WordsVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/11.
//

import UIKit
import RxSwift

class WordsVC: UIViewController {
    
    //MARK : Properties
    private let button1: UIButton = {
        let button = UIButton()
        button.setTitle("사자", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapWord), for: .touchUpInside)
        return button
    }()
    private let button2: UIButton = {
        let button = UIButton()
        button.setTitle("호랑이", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapWord), for: .touchUpInside)
        return button
    }()
    private let button3: UIButton = {
        let button = UIButton()
        button.setTitle("늑대", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapWord), for: .touchUpInside)
        return button
    }()
    
    private let seletedWordVariable = BehaviorSubject<String>(value: "var")
    var seletedWord: Observable<String>{
        return seletedWordVariable.asObserver()
    }
    
    
    
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button1.frame = CGRect(x: view.frame.size.width/2 - 50, y: view.frame.height/2-100, width: 100, height: 100)
        button2.frame = CGRect(x: view.frame.size.width/2 - 50, y: button1.frame.height+button1.frame.origin.y+20, width: 100, height: 100)
        button3.frame = CGRect(x: view.frame.size.width/2 - 50, y: button2.frame.height+button2.frame.origin.y+20, width: 100, height: 100)
    }

    @objc func didTapWord(sender : UIButton){
        guard let word = sender.titleLabel?.text else {return}
        seletedWordVariable.onNext(word)
        
    }

}
