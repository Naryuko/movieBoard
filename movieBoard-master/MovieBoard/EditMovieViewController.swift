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
    
    var ttl = ""

    override func viewDidLoad() {
        label1.text = ttl
        print(ttl)
        super.viewDidLoad()

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
