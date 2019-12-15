//
//  EditMovieViewController.swift
//  MovieBoard
//
//  Created by itct on 2019/12/10.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

class EditMovieViewController: UIViewController {
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    var ttl = ""
    var pdate = ""
    var direct = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        imageView.image = image
        label1.text! = ttl
        label2.text! = pdate
        label3.text! = direct

        
        // Do any additional setup after loading the view.
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
