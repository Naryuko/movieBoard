//
//  PinterestLayout.swift
//  MovieBoard
//
//  Created by itct on 2019/12/16.
//  Copyright © 2019 Naryu. All rights reserved.
//
// https://www.raywenderlich.com/4829472-uicollectionview-custom-layout-tutorial-pinterest 참조
import UIKit



protocol PinterestLayoutDelegate: AnyObject{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath: IndexPath) ->CGFloat
}


class PinterestLayout: UICollectionViewLayout {
    
    
    weak var delegate: PinterestLayoutDelegate?
    
    //열 개수
    var numberOfColumns = Singleton.shared.numset
    
    //cellpadding : 셀안쪽여백
    private let cellPadding: CGFloat = 5
    
    //계산해서 필요한 attributes임시저장
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat{
        guard let collectionView = collectionView else {
           return 0
        }

        let insets = collectionView.contentInset
        
        return collectionView.bounds.width - (insets.left + insets.right)

    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    //layout시작시
    override func prepare(){
        
        let numberOfColumns = Singleton.shared.numset
        
        guard
            cache.isEmpty == true || cache.isEmpty == false,
        let collectionView = collectionView
            else{
                return
        }
        
        let columWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset:[CGFloat] = []
        for colum in 0..<numberOfColumns {
            xOffset.append(CGFloat(colum)*columWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section:0)
            
            let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
            
            print(numberOfColumns)
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        
        for attributes in cache {
            if attributes.frame.intersects(rect){
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    
}


