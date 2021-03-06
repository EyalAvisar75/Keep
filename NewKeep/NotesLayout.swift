//
//  NotesLayout.swift
//  NewKeep
//
//  Created by eyal avisar on 06/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

protocol NotesLayoutDelegate: AnyObject {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForLabelAtIndexPath indexPath: IndexPath) -> CGFloat
}

class NotesLayout: UICollectionViewLayout {
    
    weak var delegate: NotesLayoutDelegate?

    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6

    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
    
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
      guard
//        cache.isEmpty,
        let collectionView = collectionView
        else {
          return
      }

    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    var xOffset: [CGFloat] = []
    var yOffset: [CGFloat] = []
//      for column in 0..<numberOfColumns {
//        xOffset.append(CGFloat(column) * columnWidth) //[0, 0.5 screen repeatedly]
//      }
    var rightColumnHeight:CGFloat = 0, leftColumnHeight:CGFloat = 0

    for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
            
        let labelHeight = delegate?.collectionView(
            collectionView,
            heightForLabelAtIndexPath: indexPath) ?? 70
        if rightColumnHeight < leftColumnHeight {
            yOffset.append(rightColumnHeight)
            rightColumnHeight += labelHeight
            xOffset.append(columnWidth)
        }
        else {
            yOffset.append(leftColumnHeight)
            leftColumnHeight += labelHeight
            xOffset.append(0)
        }
    }
//      var column = 0
    var index = 0
        
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
          
        let labelHeight = delegate?.collectionView(
          collectionView,
          heightForLabelAtIndexPath: indexPath) ?? 70
        let height = cellPadding * 2 + labelHeight
        let frame = CGRect(x: xOffset[index],
                           y: yOffset[index],
                           width: columnWidth,
                           height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding + 5)
          
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
          
        contentHeight = max(contentHeight, frame.maxY)
//        yOffset[column] = yOffset[column] + height
        
//        print(yOffset)
        index += 1
//        column = column < (numberOfColumns - 1) ? (column + 1) : 0
      }
    }

    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }

}
