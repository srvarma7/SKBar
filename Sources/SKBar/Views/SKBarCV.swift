//
//  SKBarCV.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit

final class SKBarCV: UICollectionView {
    
}

extension SKBarCV {
    static func create() -> SKBarCV {
        let horizontalFlowLayout = SKBarFlowLayout()
        horizontalFlowLayout.scrollDirection = .horizontal
        
        let cv = SKBarCV(frame: .zero, collectionViewLayout: horizontalFlowLayout)
        
        cv.register(SKBarImageLabelCell.self, forCellWithReuseIdentifier: SKBarImageLabelCell.id)
        cv.register(SKBarLabelCell.self, forCellWithReuseIdentifier: SKBarLabelCell.id)
        
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceHorizontal = true
        cv.backgroundColor = .clear
        
        /// Set the boolean to false, to enable edge swiping.
        /// Tab interaction is loosing its playfulness when edge swiping is enabled.
        let enableEdgeSwipeToDismiss = true
        cv.bounces = enableEdgeSwipeToDismiss
        return cv
    }
}
