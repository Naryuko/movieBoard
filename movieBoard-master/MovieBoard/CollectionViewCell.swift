//
//  CollectionViewCell.swift
//  MovieBoard
//
//  Created by itct on 2019/12/09.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class{
    func delete(cell: CollectionViewCell)
}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellimage: UIImageView!
    @IBOutlet weak var deleteButtonBackground: UIVisualEffectView!
    weak var delegate: CollectionViewCellDelegate?
    

    var isEditing: Bool = false {
        didSet {
            deleteButtonBackground.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
}

