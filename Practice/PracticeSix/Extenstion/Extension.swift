//
//  Extension.swift
//  RxSwiftPractice
//
//  Created by do_yun on 2022/01/17.
//

import Foundation
import UIKit
import Kingfisher

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    public var height: CGFloat {
        return self.frame.size.height
    }
    public var top: CGFloat {
        return self.frame.origin.y
    }
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat {
        return self.frame.origin.x
    }
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}



extension UIImageView {
    //서버에서 이미지 가져오기
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { result in // 캐시에서 키를 통해 이미지를 가져온다.
            switch result {
            case .success(let value):
                if let image = value.image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    guard let url = URL(string: urlString) else { return }
                    let resource = ImageResource(downloadURL: url, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                    self.kf.setImage(with: resource) // 이미지를 셋한다.
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //서버에서 받아온 이미지 cornerRadius적용하기
    func download(url: String?, rounded: Bool = true) {
        guard let _url = url else {
            return
        }
        if rounded {
            let processor = ResizingImageProcessor(referenceSize: self.frame.size) |> RoundCornerImageProcessor(cornerRadius: self.frame.size.width / 2)
            self.kf.setImage(with: URL(string: _url), placeholder: nil, options: [.processor(processor)])
        } else {
            self.kf.setImage(with: URL(string: _url))
        }
    }

}
