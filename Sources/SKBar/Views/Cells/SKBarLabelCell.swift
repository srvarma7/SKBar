//
//  SKBarLabelCell.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import EasyPeasy

class SKBarLabelCell: SKBarBaseCell {
    static let id: String  = "SKBarLabelCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(title)
        title.easy.layout(Center())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.isHidden = false
        imageView.image = cellData?.image
        title.textColor = cellConfiguration?.titleColor
    }
}

extension SKBarLabelCell {
    static func size(text: String, font: UIFont?) -> CGSize {
        return SKBarBaseCell.textSize(text: text, font: font)
    }
}
