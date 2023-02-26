//
//  SKBarBaseCell.swift
//  
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import EasyPeasy


class SKBarBaseCell: UICollectionViewCell {
    
    var cellData: SKBarContentModel?
    var cellConfiguration: SKBarConfiguration?
    
    var isActive = false
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
//        contentView.backgroundColor = .gray.withAlphaComponent(0.3)
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


// MARK: - Animations


extension SKBarBaseCell {
    func animateState(isActive: Bool, completion: @escaping (Bool) -> Void) {
        guard let cellConfiguration else {
            completion(false)
            return
        }
        self.isActive = isActive
        let baseDuration = 0.3
        let finalDuration = isActive ? baseDuration + 0.1 : baseDuration
        
        UIView.transition(with: title, duration: finalDuration, options: .transitionCrossDissolve) { [self] in
            title.textColor = isActive ? cellConfiguration.selectedTitleColor : cellConfiguration.titleColor
        }
        
        UIView.transition(with: imageView, duration: finalDuration, options: .transitionCrossDissolve) { [self] in
            var toImage = cellData?.image
            if let selectedImage = cellData?.selectedImage {
                toImage = selectedImage
            } else {
                imageView.tintColor = isActive ? cellConfiguration.selectedTitleColor : cellConfiguration.titleColor
            }
            imageView.image = toImage
        }
    }
}


// MARK: - Size helper


extension SKBarBaseCell {
    static func textSize(text: String, font: UIFont?) -> CGSize {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 1
        label.font = font
        label.sizeToFit()
        return label.intrinsicContentSize
    }
}


// MARK: - Bind


extension SKBarBaseCell {
    func bind(model: SKBarContentModel, configuration: SKBarConfiguration?, isActive: Bool) {
        cellData = model
        cellConfiguration = configuration
        self.isActive = isActive
        
        title.text      = model.title
        title.isHidden  = (model.title == "" || model.title == "0")
        imageView.image = model.image
        
        guard let configuration = configuration else { return }
        configureCell(model: model, configuration: configuration)
    }
    
    private func configureCell(model: SKBarContentModel, configuration: SKBarConfiguration) {
        imageView.image = isActive ? model.selectedImage ?? model.image : model.image
        title.font      = isActive ? configuration.selectedFont : configuration.font
        title.textColor = isActive ? configuration.selectedTitleColor ?? configuration.titleColor : configuration.titleColor
        
        title.textColor = isActive ? configuration.selectedTitleColor : configuration.titleColor
        if model.selectedImage == nil {
            imageView.tintColor = isActive ? configuration.selectedTitleColor : configuration.titleColor
        }
    }
}
