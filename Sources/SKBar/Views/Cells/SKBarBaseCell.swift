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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        contentView.layer.borderColor   = cellConfiguration?.itemBorderColor?.cgColor
        contentView.layer.borderWidth   = cellConfiguration?.itemBorderWidth ?? 0
        contentView.backgroundColor     = cellConfiguration?.itemBackgroundColor
    }
}


// MARK: - Animations


extension SKBarBaseCell {
    func animateState(isActive: Bool, completion: @escaping (Bool) -> Void) {
        guard let cellConfiguration = cellConfiguration else {
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
    
    func animateState(isActive: Bool, percentage: CGFloat, completion: @escaping (Bool) -> Void) {
        guard let cellConfiguration = cellConfiguration else {
            completion(false)
            return
        }
        self.isActive = isActive
        let baseDuration = 0.3
        let finalDuration = isActive ? baseDuration + 0.1 : baseDuration
        
        let titleColor: UIColor
        if percentage == 1, isActive {
            titleColor = cellConfiguration.selectedTitleColor ?? cellConfiguration.titleColor
        } else if percentage == 0, !isActive {
            titleColor = cellConfiguration.titleColor
        } else {
            titleColor = [cellConfiguration.selectedTitleColor ?? cellConfiguration.titleColor, cellConfiguration.titleColor].intermediate(percentage: percentage)
        }
        
        UIView.transition(with: title, duration: finalDuration, options: .transitionCrossDissolve) { [self] in
            title.textColor = titleColor
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
        
        contentView.layer.borderColor   = configuration.itemBorderColor?.cgColor
        contentView.layer.borderWidth   = configuration.itemBorderWidth ?? 0
        contentView.backgroundColor     = configuration.itemBackgroundColor
    }
}

extension Array where Element: UIColor {
    func intermediate(percentage: CGFloat) -> UIColor {
        let percentage = Swift.max(Swift.min(percentage, 100), 0) / 100
        switch percentage {
            case 0: return first ?? .clear
            case 1: return last ?? .clear
            default:
                let approxIndex = percentage / (1 / CGFloat(count - 1))
                let firstIndex = Int(approxIndex.rounded(.down))
                let secondIndex = Int(approxIndex.rounded(.up))
                let fallbackIndex = Int(approxIndex.rounded())
                
                let firstColor = self[firstIndex]
                let secondColor = self[secondIndex]
                let fallbackColor = self[fallbackIndex]
                
                var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
                var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
                guard firstColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return fallbackColor }
                guard secondColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return fallbackColor }
                
                let intermediatePercentage = approxIndex - CGFloat(firstIndex)
                return UIColor(red: CGFloat(r1 + (r2 - r1) * intermediatePercentage),
                               green: CGFloat(g1 + (g2 - g1) * intermediatePercentage),
                               blue: CGFloat(b1 + (b2 - b1) * intermediatePercentage),
                               alpha: CGFloat(a1 + (a2 - a1) * intermediatePercentage))
        }
    }
}
