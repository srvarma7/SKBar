//
//  SKBarConfiguration.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit

public struct SKBarConfiguration: Equatable {
    let titleColor: UIColor
    let font: UIFont
    
    let selectedTitleColor: UIColor?
    let selectedFont: UIFont
    
    let highlightedTitleColor: UIColor?
    
    let indicatorColor: UIColor
    let underlineColor: UIColor
    
    var itemBorderColor: UIColor? = nil
    var itemBorderWidth: CGFloat? = nil
    var itemBackgroundColor: UIColor? = nil
    
    public init(titleColor: UIColor,
                font: UIFont,
                selectedTitleColor: UIColor?,
                selectedFont: UIFont,
                highlightedTitleColor: UIColor?,
                indicatorColor: UIColor,
                separatorColor: UIColor,
                itemBorderColor: UIColor? = nil,
                itemBorderWidth: CGFloat? = nil,
                itemBackgroundColor: UIColor? = nil
    ) {
        
        self.titleColor = titleColor
        self.font = font
        self.selectedTitleColor = selectedTitleColor
        self.selectedFont = selectedFont
        self.highlightedTitleColor = highlightedTitleColor
        self.indicatorColor = indicatorColor
        self.underlineColor = separatorColor
        self.itemBorderColor = itemBorderColor
        self.itemBorderWidth = itemBorderWidth
        self.itemBackgroundColor = itemBackgroundColor
    }
}
