//
//  SearchTableViewCell.swift
//  MovieBoard
//
//  Created by itct on 2019/12/09.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

protocol SearchTabelViewprotocol {
    
    func onClickCell(index: Int)
}

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var imagelabel: UIImageView!
    
    var cellDelegate: SearchTabelViewprotocol?
    var index: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func addbutton(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
        


    }
    
    
}
