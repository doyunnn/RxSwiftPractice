//
//  ArticleStretchyHeaderView.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/18.
//

import UIKit

class ArticleStretchyHeaderView: UIView {

    // MARK : properties
    public let headerView: UIImageView = {
         let view = UIImageView()
        
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
          return view
      }()

    private var headerViewHeight = NSLayoutConstraint()
    private var headerViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
    //MARK : Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Create subviews
    private func createViews() {
        addSubview(containerView)
        containerView.addSubview(headerView)
    }
    
    // Sets up view constraints
    func setViewConstraints(){
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerViewBottom = headerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        headerViewBottom.isActive = true
        headerViewHeight = headerView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        headerViewHeight.isActive = true
        


    }
    
    // Notify view of scroll change from container
    public func scrollViewDidScroll(scrollView: UIScrollView){
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        headerViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        headerViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }

}
