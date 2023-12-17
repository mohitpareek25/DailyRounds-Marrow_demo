//
//  ImageLayer.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//

import Foundation
import Kingfisher


class ImageLayer {
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(UIImage(named: "book"))
            return
        }
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: url) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure:
                completion(UIImage(named: "book"))
            }
        }
    }
}
