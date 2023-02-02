//
//  TitleExamples.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import SKBar

extension SKBar {
    
    static let titleItems = [
        SKBarContentModel(title: "Welcome"),
        SKBarContentModel(title: "to"),
        SKBarContentModel(title: "SKBar"),
        SKBarContentModel(title: "This"),
        SKBarContentModel(title: "is"),
        SKBarContentModel(title: "a"),
        SKBarContentModel(title: "very"),
        SKBarContentModel(title: "simple"),
        SKBarContentModel(title: "example"),
        SKBarContentModel(title: "project"),
        SKBarContentModel(title: "with"),
        SKBarContentModel(title: "Title"),
        SKBarContentModel(title: "theme"),
    ]
    
    static func ex1(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.3),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .black,
                                        selectedFont: .systemFont(ofSize: 15),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .black,
                                        separatorColor: .black.withAlphaComponent(0.2))
        
        
        let titleTheme: SKBarContentType = .title
        
        lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.items = titleItems
        
        return skBar
    }
    
    static func ex2(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.3),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .black,
                                        selectedFont: .systemFont(ofSize: 15),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .black,
                                        separatorColor: .black.withAlphaComponent(0.1))
        
        
        let titleTheme: SKBarContentType = .title
        
        lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.indicatorHInset = 5
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.items = Array(titleItems[0...2])
        
        return skBar
    }
    
    static func ex3(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.4),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .orange,
                                        selectedFont: .systemFont(ofSize: 15),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .orange,
                                        separatorColor: .orange.withAlphaComponent(0.1))
        
        
        let titleTheme: SKBarContentType = .title
        
        lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.items = Array(titleItems[0...2])
        skBar.alignment = .leading
        
        return skBar
    }
}
