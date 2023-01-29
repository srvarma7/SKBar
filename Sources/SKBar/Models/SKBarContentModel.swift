//
//  SKBarContentModel.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit

public struct SKBarContentModel: Equatable {
    let title: String
    var image: UIImage? = nil
    var selectedImage: UIImage? = nil
    
    public init(title: String, image: UIImage? = nil, selectedImage: UIImage? = nil) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
}
