//
//  TitleWithImagesExample.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 01/02/23.
//

import UIKit
import SKBar

extension SKBar {
    
    static let itemsWithImages = [
        SKBarContentModel(title: "Avocado", image: .avocado),
        SKBarContentModel(title: "Cauliflower", image: .cauliflower),
        SKBarContentModel(title: "Cherry", image: .cherry),
        SKBarContentModel(title: "Cupcake", image: .cupcake),
        SKBarContentModel(title: "Donut", image: .donut),
        SKBarContentModel(title: "GrapesBlue", image: .grapesBlue),
        SKBarContentModel(title: "GrapesViolet", image: .grapesViolet),
        SKBarContentModel(title: "Orange", image: .orange),
        SKBarContentModel(title: "Pumpkin", image: .pumpkin),
        SKBarContentModel(title: "Strawberry", image: .strawberry),
        SKBarContentModel(title: "Tomato", image: .tomato)
    ]
    
    static func ex4(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.4),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .orange,
                                        selectedFont: .systemFont(ofSize: 15),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .orange,
                                        separatorColor: .orange.withAlphaComponent(0.1))
        
        
        let imageAndTitle: SKBarContentType = .imageAndTitle
        
        lazy var skBar = SKBar(frame: .zero, theme: imageAndTitle)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.indicatorHInset = 20
        skBar.items = itemsWithImages.reversed()
        skBar.alignment = .leading
        
        return skBar
    }
    
    static func ex5(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.4),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .orange,
                                        selectedFont: .systemFont(ofSize: 15),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .orange,
                                        separatorColor: .orange.withAlphaComponent(0.1))
        
        
        let imageAndTitle: SKBarContentType = .imageAndTitle
        
        lazy var skBar = SKBar(frame: .zero, theme: imageAndTitle)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.items = Array(itemsWithImages[0...2])
        skBar.alignment = .leading
        
        return skBar
    }
    
    static func ex6(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.4),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .orange,
                                        selectedFont: .systemFont(ofSize: 15),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .orange,
                                        separatorColor: .orange.withAlphaComponent(0.1))
        
        
        let imageAndTitle: SKBarContentType = .imageAndTitle
        
        lazy var skBar = SKBar(frame: .zero, theme: imageAndTitle)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.indicatorHInset = 5
        skBar.configuration = config
        skBar.items = Array(itemsWithImages[0...1])
        skBar.alignment = .leading
        
        return skBar
    }

}
