//
//  TitleExamples.swift
//  SKBarExample
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import SKBar

extension SKBar {
    
    static let numbersInWords: [String] = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
                                           "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty",
                                           "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety", "Hundred"]
    
    static let numbersInWordsTitleItems: [SKBarContentModel] = {
        let general: [SKBarContentModel] = [
            SKBarContentModel(title: "WelcomeeeeeeeeeeeeeeeeeW"),
            SKBarContentModel(title: "to"),
            SKBarContentModel(title: "SKBar"),
            SKBarContentModel(title: "This"),
            SKBarContentModel(title: "is"),
            SKBarContentModel(title: "a"),
            SKBarContentModel(title: "large"),
            SKBarContentModel(title: "Example"),
            SKBarContentModel(title: "for"),
            SKBarContentModel(title: "reuse"),
            SKBarContentModel(title: "test"),
        ]
        let numbers: [SKBarContentModel] = numbersInWords.map({ SKBarContentModel(title: $0) })
        return general + numbers
    }()
    
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
    
    static func tex1(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.3),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .white,
                                        selectedFont: .systemFont(ofSize: 18),
                                        highlightedTitleColor: .systemBlue,
                                        indicatorColor: .systemBlue,
                                        separatorColor: .clear)
        
        
        let titleTheme: SKBarContentType = .title
        
        lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.indicatorStyle = .capsule
        skBar.indicatorCornerRadius = 20
        skBar.minimumItemWidth = 40
        skBar.items = titleItems
        
        return skBar
    }
    
    static func tex2(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.3),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .black,
                                        selectedFont: .systemFont(ofSize: 18),
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
    
    static func tex3(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .black.withAlphaComponent(0.4),
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .orange,
                                        selectedFont: .systemFont(ofSize: 18),
                                        highlightedTitleColor: .blue,
                                        indicatorColor: .orange,
                                        separatorColor: .orange.withAlphaComponent(0.1))
        
        
        let titleTheme: SKBarContentType = .title
        
        lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.alignment = .leading
        skBar.items = Array(titleItems[0...2])
        
        return skBar
    }
    
    static func tex4(edgePadding: CGFloat, interItemSpacing: CGFloat) -> SKBar {
        
        let config = SKBarConfiguration(titleColor: .textSecondary,
                                        font: .systemFont(ofSize: 18),
                                        selectedTitleColor: .textPrimaryContrary,
                                        selectedFont: .systemFont(ofSize: 18),
                                        highlightedTitleColor: .systemBlue,
                                        indicatorColor: .accentPrimary,
                                        separatorColor: .clear)
        
        
        let titleTheme: SKBarContentType = .title
        
        lazy var skBar = SKBar(frame: .zero, theme: titleTheme)
        
        let padding: CGFloat = edgePadding
        skBar.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        skBar.interItemSpacing = interItemSpacing
        skBar.configuration = config
        skBar.indicatorStyle = .capsule
        skBar.indicatorCornerRadius = 20
        skBar.minimumItemWidth = 40
        skBar.activeItemVisibilityPosition = .natural(custom: .centre)
        skBar.items = SKBar.numbersInWordsTitleItems
        
        return skBar
    }
}
