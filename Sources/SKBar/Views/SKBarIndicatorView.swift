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
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    required init(frame: CGRect, theme: SKBarContentType) {
        self.theme = theme
        super.init(frame: frame)
        addSubview(indicatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let indicatorHeight: CGFloat
        indicatorHeight = bounds.height
        //        switch theme {
        //            case .title:
        //                indicatorHeight = bounds.height
        //            case .imageAndTitle:
        //                indicatorHeight = bounds.height*2
        //                indicatorView.cornerRadius = indicatorHeight/2
        //        }
        indicatorView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: indicatorHeight)
    }
}
