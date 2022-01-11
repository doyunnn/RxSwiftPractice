//
//  PracticeThreeRootVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/11.
//

import UIKit
import RxSwift

// 뷰간 데이터 이동 연습
class PracticeThreeRootVC: UIViewController {

    //MARK : Properties
    let disposeBag = DisposeBag()
    
    private let label : UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .systemBlue
        label.text = "안녕 난 ..야"
        label.textAlignment = .center
        return label
    }()
    
    //MARK : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapActionButton))
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: view.frame.height/2-50, width: view.frame.size.width, height: 100)
    }
    
    //MARK : Helpers
    @objc func didTapActionButton(){
        let vc = WordsVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.seletedWord.subscribe(onNext: { [weak self] word in
            self?.label.text = "안녕 난 \(word)야"
        }).disposed(by: disposeBag)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    

}
