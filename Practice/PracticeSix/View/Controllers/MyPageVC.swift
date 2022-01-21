//
//  MyPageVC.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/19.
//

import UIKit

class MyPageVC: UIViewController {
    //MAKR : Properties
    
    private let viewModel = ProfileViewModel()
    
    private let myPageLabel : UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let userImage : UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = .lightGray
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let userEmail : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let line : UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bookMarkView : UIView = {
       let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.8
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bookMarkLabel : UILabel = {
       let label = UILabel()
        label.text = "내가 북마크한 리스트 보기"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let logoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MAKR : Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigure()
        didTapBookMarkView()
    }
    
    //MARK : Configure
    func defaultConfigure(){
        let padding :CGFloat = 20
        title = ""
        view.backgroundColor = .white
        view.addSubview(myPageLabel)
        myPageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        myPageLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: padding).isActive = true
        myPageLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -padding).isActive = true
        
        view.addSubview(userImage)
        userImage.topAnchor.constraint(equalTo: myPageLabel.bottomAnchor,constant: padding).isActive = true
        userImage.leftAnchor.constraint(equalTo: view.leftAnchor,constant: padding).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(userEmail)
        userEmail.leftAnchor.constraint(equalTo: userImage.rightAnchor,constant: 10).isActive = true
        userEmail.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -padding).isActive = true
        userEmail.bottomAnchor.constraint(equalTo: userImage.bottomAnchor).isActive = true
        guard let email = viewModel.email else {return}
        userEmail.text = email
        
        view.addSubview(line)
        line.topAnchor.constraint(equalTo: userImage.bottomAnchor,constant: padding).isActive = true
        line.leftAnchor.constraint(equalTo: view.leftAnchor,constant: padding).isActive = true
        line.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -padding).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addSubview(bookMarkView)
        bookMarkView.topAnchor.constraint(equalTo: line.bottomAnchor,constant: padding).isActive = true
        bookMarkView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: padding).isActive = true
        bookMarkView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -padding).isActive = true
        bookMarkView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bookMarkView.addSubview(bookMarkLabel)
        bookMarkLabel.leftAnchor.constraint(equalTo: bookMarkView.leftAnchor,constant: 10).isActive = true
        bookMarkLabel.centerYAnchor.constraint(equalTo: bookMarkView.centerYAnchor).isActive = true
        
        view.addSubview(logoutButton)
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    //MAKR: Helper
    @objc func didTapLogout(){
        viewModel.logout(vc: self)
    }
    
    func didTapBookMarkView() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.didTapBookMarkList))
        bookMarkView.addGestureRecognizer(tap)
    }
    
    @objc func didTapBookMarkList() {
        let vc = ScrapListVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
