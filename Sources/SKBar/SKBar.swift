//
//  SKIndicatorView.swift
//
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import EasyPeasy


// Notification
    // Position
        // Top - left, right
    // Color
    // Size
        // small, medium, large
    // Style
        // dot, square, star
    // Dismiss
        // onSelect, manual

// Reveal items
    
// Floating sub menus


public enum SKBarContentType {
    case title, imageAndTitle
}

public enum SKBarAlignment {
    case leading, centre, auto
}

public enum SKBarIndicatorLinePosition {
    case top, bottom
}

public enum SKBarIndicatorStyle {
//    case line(position: SKBarIndicatorLinePosition, height: CGFloat), capsule(cornerRadius: CGFloat)
    case line, capsule
}

public protocol SKBarDelegate: AnyObject {
    func didSelectSKBarItemAt(_ skBar: SKBar, _ index: Int)
}

public class SKBar: UIView {
    
    
    // MARK: - Properties
    
    
    public var alignment: SKBarAlignment = .auto
    
    public var theme: SKBarContentType
    
    public var indicatorStyle: SKBarIndicatorStyle = .line {
        didSet {
            reload()
        }
    }
    
    public var minimumItemWidth: CGFloat = 0
    
    public var totalContentsSize: CGFloat = 0

    
    // MARK: - Indicator Properties
    
    
    public enum SelectedItemVisibilityPosition {
        case left, right, centre, natural
        
        var position: UICollectionView.ScrollPosition {
            switch self {
                case .left:
                    return .left
                case .right:
                    return .right
                case .centre, .natural:
                    return .centeredHorizontally
            }
        }
    }
    public var indicatorCornerRadius: CGFloat = 0
    public var indicatorHeight: CGFloat = 1 {
        didSet {
            moveIndicator(toIndex: selectedIndex)
        }
    }
    public var indicatorHInset: CGFloat = .zero {
        didSet {
            reload()
        }
    }
    public var activeItemVisibilityPosition: SelectedItemVisibilityPosition = .centre
    
    
    public weak var delegate: SKBarDelegate?
    
    private(set) var selectedIndex = 0
    
    public var currentIndex: Int {
        return selectedIndex
    }
    
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            reload()
        }
    }
    
    
    public var interItemSpacing: CGFloat = 5 {
        didSet {
            guard oldValue != interItemSpacing else {
//                print("Not refreshing as interItemSpacing is same")
                return
            }
            reload()
        }
    }
    
    public var items: [SKBarContentModel] = [] {
        didSet {
            guard oldValue != items else {
//                print("Not refreshing as items are same")
                return
            }
            reload()
        }
    }
    
    public var configuration: SKBarConfiguration? {
        didSet {
            guard oldValue != configuration else {
//                print("Not refreshing as configuration is same")
                return
            }
            reload()
        }
    }
    
    
    // MARK: - Views
    
    
    lazy private var indicatorView: SKBarIndicatorView = {
        let view = SKBarIndicatorView(frame: .zero, theme: theme)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy private var barCollectionView: SKBarCV = {
        let cv = SKBarCV.create()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    // MARK: - deinit
    
    
    deinit {
//        print("✅✅✅ Tab Control dealloc ✅✅✅")
    }
    
    
    // MARK: - init
    
    
    public required init(frame: CGRect, theme: SKBarContentType) {
        self.theme = theme
        super.init(frame: frame)
        addSubview(indicatorView)
        addSubview(barCollectionView)
        barCollectionView.easy.layout(
            Top(),
            Leading(),
            Trailing(),
            Bottom()
        )
        
        addSubview(underlineView)
        underlineView.easy.layout(
            Bottom(),
            Leading(),
            Trailing(),
            Height(1)
        )
        indicatorView.frame = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
//        moveIndicator(toIndex: selectedIndex, animated: false)
//        moveIndicator(toIndex: selectedIndex, animated: false)
    }
}


// MARK: - Scroll change


extension SKBar {
    public func reload() {
        barCollectionView.reloadData()
        UIView.animate(withDuration: 0.2, delay: 0.1) { [self] in
            underlineView.backgroundColor = configuration?.underlineColor
            indicatorView.backgroundColor = configuration?.indicatorColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [self] in
            moveIndicator(toIndex: selectedIndex)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveIndicator(toIndex: selectedIndex, animated: false)
    }
}


// MARK: - UICollectionViewDataSource


extension SKBar: UICollectionViewDataSource {
    
    
    // MARK: - No of cells
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    
    // MARK: - Cell for item at
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SKBarBaseCell
        switch theme {
            case .title:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: SKBarLabelCell.id, for: indexPath) as! SKBarLabelCell
            case .imageAndTitle:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: SKBarImageLabelCell.id, for: indexPath) as! SKBarImageLabelCell
        }
        let row = indexPath.row
        let item = items[row]
        cell.bind(model: item, configuration: configuration, isActive: row == selectedIndex)
        return cell
    }
    
    
    // MARK: - Cell willDisplay
    
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SKBarBaseCell else {
            return
        }
        let row = indexPath.row
        let item = items[row]
        cell.bind(model: item, configuration: configuration, isActive: row == selectedIndex)
    }
    
    
    // MARK: - Cell didEndDisplaying
    
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}


// MARK: - UICollectionViewDelegate


extension SKBar: UICollectionViewDelegate {
    
    
    // MARK: - Cell did select
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setSelectedIndex(indexPath.row)
    }
    
    public func setSelectedIndex(_ index: Int, animated: Bool = true) {
        guard let _ = items[safe: index] else {
//             assertionFailure("Index out of bounds. Bar item at index - \(index) is not available to select.")
            return
        }
        
        if selectedIndex != index {
            let oldSelectedIndexPath = IndexPath(row: selectedIndex, section: 0)
            let newSelectedIndexPath = IndexPath(row: index, section: 0)
            
            if animated {
                (barCollectionView.cellForItem(at: oldSelectedIndexPath) as? SKBarBaseCell)?.animateState(isActive: false) { _ in }
                (barCollectionView.cellForItem(at: newSelectedIndexPath) as? SKBarBaseCell)?.animateState(isActive: true) { _ in }
            } else {
                barCollectionView.reloadData()
            }
            
            selectedIndex = index
            if activeItemVisibilityPosition == .natural, let cell = barCollectionView.cellForItem(at: newSelectedIndexPath) {
                if visiblePercentageInSuperView(of: cell) == 100 {
                    // Already visible, do nothing. As the item visibility behaviour is natural.
                } else {
                    barCollectionView.scrollToItem(at: newSelectedIndexPath, at: activeItemVisibilityPosition.position, animated: animated)
                }
            } else {
                barCollectionView.scrollToItem(at: newSelectedIndexPath, at: activeItemVisibilityPosition.position, animated: animated)
            }
            moveIndicator(toIndex: selectedIndex)
            delegate?.didSelectSKBarItemAt(self, index)
        } else {
            moveIndicator(toIndex: selectedIndex)
        }
    }
    
    private func visiblePercentageInSuperView(of cell: UICollectionViewCell) -> Int {
        guard let cellSuperView = cell.superview else {
            debugPrint("Error finding super view for the cell")
            return 0
        }
        
        let cellFrame = cell.frame
        let rect = cellSuperView.convert(cellFrame, from: cellSuperView)
        let intersection = rect.intersection(cellSuperView.bounds)
        let ratio = (intersection.width * intersection.height) / (cellFrame.width * cellFrame.height)
        let visiblePercentage = Int(ratio * 100)
        return visiblePercentage
    }
}


// MARK: - UICollectionViewDelegateFlowLayout


extension SKBar: UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Section insets
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let barWidth = frame.width
        let contentWidthWithInterItemSpacing = totalContentSize(withCVInsets: true)
        switch theme {
            case .title:
                switch alignment {
                    case .leading:
                        barCollectionView.contentInset = .init(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                        return .zero
                    case .centre, .auto:
                        if contentWidthWithInterItemSpacing > barWidth {
                            barCollectionView.contentInset = .init(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                            return .zero
                        } else {
                            let inset = (barWidth - contentWidthWithInterItemSpacing)/2
                            barCollectionView.contentInset = .init(top: 0, left: inset + contentInset.left, bottom: 0, right: inset + contentInset.right)
                            return .zero
                        }
                }
            case .imageAndTitle:
                if contentWidthWithInterItemSpacing > barWidth {
                    barCollectionView.contentInset = .init(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                    return .zero
                } else {
                    barCollectionView.contentInset = .init(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                    return .zero
                }
        }
    }
    
    
    // MARK: - Cell size
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let row = indexPath.row
        let item = items[row]
        var itemWidth = itemSize(item)
        let contentFittingSize = collectionView.bounds.width - (contentInset.left + contentInset.right)
        
        switch theme {
            case .title:
                return CGSize(width: itemWidth, height: 40)
            case .imageAndTitle:
#warning("Changed to false to test the profile screen")
                if totalContentSize(withCVInsets: false) > contentFittingSize {
                    if itemWidth < 50 { itemWidth = 50 }                                // Setting min size as it is already more than the content fitting size.
                    return CGSize(width: itemWidth, height: 40)
                } else {
                    var dividedWidth = contentFittingSize / CGFloat(items.count)
                    if itemWidth > dividedWidth { dividedWidth = itemWidth }
                    return CGSize(width: dividedWidth, height: 40)
                }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
}


//MARK: - Indicator Animations


extension SKBar {
    private func displayIndicator(show: Bool, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.2 : 0.0, delay: 0) { [self] in
            indicatorView.alpha = show ? 1.0 : 0.0
        }
    }
    
    public func moveIndicator(forPercentage percentage: CGFloat, from: Int, to: Int) {
        let fromIndexPath = IndexPath(row: from, section: 0)
        let toIndexPath   = IndexPath(row: to, section: 0)
        
        guard let fromCell = barCollectionView.cellForItem(at: fromIndexPath) else { return }
        guard let toCell   = barCollectionView.cellForItem(at: toIndexPath) else { return }
        
        let fromFrame = barCollectionView.convert(fromCell.frame, to: barCollectionView.superview)
        let toFrame   = barCollectionView.convert(toCell.frame, to: barCollectionView.superview)
        
        let xPosition = (fromFrame.minX * (1 - percentage)) + toFrame.minX * percentage
        let toWidth   = (fromFrame.width * (1 - percentage)) + toFrame.width * percentage
        
        let finalWidth: CGFloat
        let finalHeight: CGFloat
        let finalXPosition: CGFloat
        let finalYPosition: CGFloat
        
        switch indicatorStyle {
            case .line:
                finalXPosition = xPosition + indicatorHInset
                finalWidth = toWidth - (indicatorHInset*2)
                finalHeight = indicatorHeight
                finalYPosition = barCollectionView.frame.height - indicatorHeight
            case .capsule:
                finalXPosition = xPosition + indicatorHInset// - (indicatorCornerRadius/2)
                finalWidth = toWidth// + indicatorCornerRadius
                finalHeight = toFrame.height
                finalYPosition = toFrame.minY
        }
        
        let toIndicatorFrame = CGRect(x: finalXPosition,
                                      y: finalYPosition,
                                      width: finalWidth,
                                      height: finalHeight)
        
        _moveIndicator(frame: toIndicatorFrame, animated: true)
    }
    
    private func moveIndicator(toIndex: Int, animated: Bool = true) {
        let cellIndexPath = IndexPath(row: toIndex, section: 0)
        guard let cell = barCollectionView.cellForItem(at: cellIndexPath) else { return }
        let cellFrame = cell.frame
        let toFrame = barCollectionView.convert(cellFrame, to: barCollectionView.superview)
        
        let xPosition = toFrame.minX
        let toWidth   = toFrame.width
        
        let finalWidth: CGFloat
        let finalHeight: CGFloat
        let finalXPosition: CGFloat
        let finalYPosition: CGFloat
        
        switch indicatorStyle {
            case .line:
                finalXPosition = xPosition + indicatorHInset
                finalWidth = toWidth - (indicatorHInset*2)
                finalHeight = indicatorHeight
                finalYPosition = barCollectionView.frame.height - indicatorHeight
            case .capsule:
                finalXPosition = xPosition + indicatorHInset// - (indicatorCornerRadius/2)
                finalWidth = toWidth// + indicatorCornerRadius
                finalHeight = toFrame.height
                finalYPosition = toFrame.minY
        }
        
        let toIndicatorFrame = CGRect(x: finalXPosition,
                                      y: finalYPosition,
                                      width: finalWidth,
                                      height: finalHeight)
        
        _moveIndicator(frame: toIndicatorFrame, animated: animated)
    }
    
    private func _moveIndicator(frame toIndicatorFrame: CGRect, animated: Bool) {
        if indicatorView.frame == .zero {
            // to eliminate the initial indication animation that comes from .zero to indicatorFrame position.
            indicatorView.frame = toIndicatorFrame
            indicatorView.backgroundColor = configuration?.indicatorColor
            indicatorView.layer.cornerRadius = indicatorCornerRadius
            layoutIfNeeded()
        }
        
        UIView.animate(withDuration: animated ? 0.2 : 0.0, delay: 0, options: [.curveEaseOut]) { [self] in
            indicatorView.frame = toIndicatorFrame
            indicatorView.backgroundColor = configuration?.indicatorColor
            indicatorView.layer.cornerRadius = indicatorCornerRadius
            layoutIfNeeded()
        } completion: { [self] _ in
            indicatorView.frame = toIndicatorFrame
        }
    }
}


//MARK: - Size helpers


extension SKBar {
    
    
    // MARK: - Size
    
    
    private func totalContentSize(withCVInsets: Bool = false) -> CGFloat {
        var allCellsWidth: CGFloat = 0
        for item in items {
            let itemWidth = itemSize(item)
            allCellsWidth += itemWidth
        }
        allCellsWidth += CGFloat(items.count - 1) * interItemSpacing
        if withCVInsets {
            allCellsWidth += contentInset.left + contentInset.right
        }
        
        return allCellsWidth
    }
    
    private func itemSize(_ item: SKBarContentModel) -> CGFloat {
        switch theme {
            case .title:
                var itemWidth = SKBarLabelCell.size(text: item.title, font: configuration?.font).width
                itemWidth += indicatorCornerRadius
                if itemWidth < minimumItemWidth {
                    itemWidth = minimumItemWidth
                }
                return itemWidth
            case .imageAndTitle:
                var itemWidth = SKBarImageLabelCell.size(text: item.title, font: configuration?.font).width
                itemWidth += indicatorCornerRadius
                if minimumItemWidth > itemWidth {
                    itemWidth = minimumItemWidth
                }
                return itemWidth
        }
    }
}


//MARK: - Creation of the tabControl


//extension SKBar {
//    static let defaultHeight: CGFloat = 53
//    static func createTitleView() -> TabControlView {
//        // Setting default height will eliminate indicator appearance issue.
//        let frame = CGRect(x: 0, y: 0, width: Screen_Width, height: defaultHeight)
//        let tabControl = TabControlView(frame: frame, theme: .title)
//
//        tabControl.configuration = TabConfiguration(
//            titleColor: .textTertiary,
//            selectedTitleColor: .textPrimary,
//            highlightedTitleColor: .textPrimary,
//            font: KooFont.tabTitle!,
//            selectedFont: KooFont.tabTitle!,
//            indicatorColor: .textPrimary
//        )
//
//        tabControl.backgroundColor = .backgroundSecondary
//        tabControl.interItemSpacing = 28
//
//        let edgeInset: CGFloat = 20
//        tabControl.contentInset = UIEdgeInsets(top: 0, left: edgeInset, bottom: 2, right: edgeInset)
//        return tabControl
//    }
//}
