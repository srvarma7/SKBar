//
//  SKBarImageLabelCell.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import EasyPeasy

class SKBarImageLabelCell: SKBarBaseCell {
    static let id: String  = "SKBarImageLabelCell"
    
    static let imageSize: CGFloat = 20
    static let stackSpacing: CGFloat = 2
    static let contentPadding: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, title])
        stackView.spacing = SKBarImageLabelCell.stackSpacing
        imageView.easy.layout(Size(SKBarImageLabelCell.imageSize))
        contentView.addSubview(stackView)
        stackView.easy.layout(Center())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SKBarImageLabelCell {
    static func size(text: String, font: UIFont?) -> CGSize {
        let textSize = SKBarBaseCell.textSize(text: text, font: font)
        let height = textSize.height < SKBarImageLabelCell.imageSize ?  SKBarImageLabelCell.imageSize : textSize.height
        return CGSize(width: textSize.width + SKBarImageLabelCell.stackSpacing + SKBarImageLabelCell.imageSize + SKBarImageLabelCell.contentPadding, height: height)
    }
}
