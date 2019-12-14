//
//  SearchMovie.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/21.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation
import UIKit

class SearchMovie: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    lazy var tapRecognizer: UITapGestureRecognizer = {
       var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
       return recognizer
     }()
    
    var searchResult:[movieList] = []
    let NaverAPI = naverAPI()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    func str2Img(imageStr: String) -> UIImage? {
        if !imageStr.isEmpty {
            let imageUrl = URL(string: imageStr)
            do {
                let imageData = try Data(contentsOf: imageUrl!)
                return UIImage(data: imageData)!
            } catch let error as NSError {
                print(error)
            }
            return nil
        } else {
            return nil
        }
    }
    
    

}

extension SearchMovie: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieList", for: indexPath)
        
        let item = searchResult[indexPath.row]
        configureText(for: cell, with: item)
        configureImage(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: movieList) {
        if let label1 = cell.viewWithTag(1001) as? UILabel {
            label1.text = item.title
        }
        if let label2 = cell.viewWithTag(1002) as? UILabel {
            label2.text = item.subtitle
        }
        if let label3 = cell.viewWithTag(1003) as? UILabel {
            label3.text = "pubDate: " + item.pubDate
        }
        if let label4 = cell.viewWithTag(1004) as? UILabel {
            label4.text = "director: " + item.director
        }
        if let label5 = cell.viewWithTag(1005) as? UILabel {
            label5.text = "actor: " + item.actor
        }
        if let label6 = cell.viewWithTag(1006) as? UILabel {
            label6.text = "user rating: " + item.userRating
        }
        if let label7 = cell.viewWithTag(1007) as? UILabel {
            label7.text = item.link
        }
    }
    
    func configureImage(for cell: UITableViewCell, with item: movieList) {
        if let label = cell.viewWithTag(10) as? UIImageView {
            label.image = str2Img(imageStr: item.image)
        }
    }

}
