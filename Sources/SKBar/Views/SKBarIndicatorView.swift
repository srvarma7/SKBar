//
//  SKBarIndicatorView.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import EasyPeasy

final class SKBarIndicatorView: UIView {
    
    var theme: SKBarContentType
    
    required init(frame: CGRect, theme: SKBarContentType) {
        self.theme = theme
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
