//
//  BaseView.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import Foundation
import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) has not been implemented")
    }

    func configure() {}
    func bind() {}
}
