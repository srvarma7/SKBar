//
//  SKIndicatorView.swift
//
//
//  Created by Sai Kallepalli on 29/01/23.
//

import UIKit
import EasyPeasy

public enum SKBarContentType {
    case title, imageAndTitle
}

public enum SKBarAlignment {
    case leading, centre, auto
}

public protocol SKBarDelegate: AnyObject {
    func didSelectSKBarItemAt(_ skBar: SKBar, _ index: Int)
}

public class SKBar: UIView {
    
    
    // MARK: - Properties
    
    
    public var alignment: SKBarAlignment = .auto
    
    public var theme: SKBarContentType
    
    public var totalContentsSize: CGFloat = 0
    
    public var indicatorHeight: CGFloat = 1 {
        didSet {
            moveIndicator(toIndex: selectedIndex, animated: false)
        }
    }
    
    public var delegate: SKBarDelegate?
    
    private(set) var selectedIndex = 0
    
    public var currentIndex: Int {
        return selectedIndex
    }
    
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            reload()
        }
    }
    
    public var indicatorHInset: CGFloat = .zero {
        didSet {
            reload()
        }
    }
    
    public var interItemSpacing: CGFloat = 5 {
        didSet {
            guard oldValue != interItemSpacing else {
                print("Not refreshing as interItemSpacing is same")
                return
            }
            reload()
        }
    }
    
    public var items: [SKBarContentModel] = [] {
        didSet {
            guard oldValue != items else {
                print("Not refreshing as items are same")
                return
            }
            reload()
        }
    }
    
    public var configuration: SKBarConfiguration? {
        didSet {
            guard oldValue != configuration else {
                print("Not refreshing as configuration is same")
                return
            }
            reload()
        }
    }
    
    
    // MARK: - Views
    
    
    lazy private var indicatorView: SKBarIndicatorView = {
        let view = SKBarIndicatorView(frame: .zero, theme: theme)
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
        print("✅✅✅ Tab Control dealloc ✅✅✅")
    }
    
    
    // MARK: - init
    
    
    public required init(frame: CGRect, theme: SKBarContentType) {
        self.theme = theme
        super.init(frame: frame)
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
        addSubview(indicatorView)
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
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SKBarBaseCell else {
            return
        }
        let row = indexPath.row
        let item = items[row]
        cell.bind(model: item, configuration: configuration, isActive: row == selectedIndex)
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
            assertionFailure("Index out of bounds. Bar item at index - \(index) is not available to select.")
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
            barCollectionView.scrollToItem(at: newSelectedIndexPath, at: .centeredHorizontally, animated: animated)
            moveIndicator(toIndex: selectedIndex)
            delegate?.didSelectSKBarItemAt(self, index)
        } else {
            moveIndicator(toIndex: selectedIndex)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout


extension SKBar: UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Section insets
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let tabWidth = frame.width
        let contentWidthWithInterItemSpacing = totalContentSize(withCVInsets: true)
        switch theme {
            case .title:
                switch alignment {
                    case .leading:
                        return UIEdgeInsets(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                    case .centre, .auto:
                        if contentWidthWithInterItemSpacing > tabWidth {
                            return UIEdgeInsets(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                        } else {
                            let inset = (tabWidth - contentWidthWithInterItemSpacing)/2
                            return UIEdgeInsets(top: 0, left: inset + contentInset.left, bottom: 0, right: inset + contentInset.right)
                        }
                }
            case .imageAndTitle:
                if contentWidthWithInterItemSpacing > tabWidth {
                    return UIEdgeInsets(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
                } else {
                    return UIEdgeInsets(top: 0, left: contentInset.left, bottom: 0, right: contentInset.right)
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
                return CGSize(width: SKBarLabelCell.size(text: item.title, font: configuration?.font).width, height: 40)
            case .imageAndTitle:
                if totalContentSize(withCVInsets: true) > contentFittingSize {
                    if itemWidth < 50 { itemWidth = 50 } // Setting min size as it is already more than the content fitting size.
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


//MARK: - Animations


extension SKBar {
    public func moveIndicator(forPercentage percentage: CGFloat, from: Int, to: Int) {
        let fromIndexPath = IndexPath(row: from, section: 0)
        let toIndexPath   = IndexPath(row: to, section: 0)
        
        guard let fromCell = barCollectionView.cellForItem(at: fromIndexPath) else { return }
        guard let toCell   = barCollectionView.cellForItem(at: toIndexPath) else { return }
        
        let fromFrame = barCollectionView.convert(fromCell.frame, to: barCollectionView.superview)
        let toFrame   = barCollectionView.convert(toCell.frame, to: barCollectionView.superview)
        
        let xPosition = (fromFrame.minX * (1 - percentage)) + toFrame.minX * percentage
        let width     = (fromFrame.width * (1 - percentage)) + toFrame.width * percentage
        
        let toIndicatorFrame = CGRect(x: xPosition + indicatorHInset,
                                      y: indicatorView.frame.minY,
                                      width: width - (indicatorHInset*2),
                                      height: indicatorView.frame.height)
        
        print("fromFrame       ", fromFrame)
        print("toFrame         ", toFrame)
        print("toIndicatorFrame", toIndicatorFrame, "\n")
        
        UIView.animate(withDuration: 0.0, delay: 0, options: [.curveEaseOut, .beginFromCurrentState]) { [self] in
            indicatorView.frame = toIndicatorFrame
            layoutIfNeeded()
        } completion: { _ in }
    }
    
    private func moveIndicator(toIndex: Int, animated: Bool = true) {
        let cellIndexPath = IndexPath(row: toIndex, section: 0)
        guard let cell = barCollectionView.cellForItem(at: cellIndexPath) else { return }
        let cellFrame = cell.frame
        let frame = barCollectionView.convert(cellFrame, to: barCollectionView.superview)
        
        let indicatorFrame = CGRect(x: frame.minX + indicatorHInset,
                                    y: barCollectionView.frame.height - indicatorHeight,
                                    width: frame.width - (indicatorHInset*2),
                                    height: indicatorHeight)
        
        if indicatorView.frame == .zero {
            // to eliminate the initial indication animation that comes from .zero to indicatorFrame position.
            indicatorView.frame = indicatorFrame
        }
        
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState]) { [self] in
                indicatorView.frame = indicatorFrame
                indicatorView.backgroundColor = configuration?.indicatorColor
                layoutIfNeeded()
            } completion: { _ in }
        } else {
            indicatorView.frame = indicatorFrame
        }
    }
}


//MARK: - Size helpers


extension SKBar {
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
                return SKBarLabelCell.size(text: item.title, font: configuration?.font).width
            case .imageAndTitle:
                return SKBarImageLabelCell.size(text: item.title, font: configuration?.font).width
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
