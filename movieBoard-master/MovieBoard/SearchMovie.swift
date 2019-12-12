//
//  SearchMovie.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/21.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation
import UIKit
import CoreData


    
    

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieList", for: indexPath) as? SearchTableViewCell
        cell?.cellDelegate = self
        cell?.index = indexPath
        
        let item = searchResult[indexPath.row]
        
        cell?.label1.text = item.title
        cell?.label2.text = item.subtitle
        cell?.label3.text = "pubDate: " + item.pubDate
        cell?.label4.text = "director: " + item.director
        cell?.label5.text = "actor: " + item.actor
        cell?.label6.text = "user rating: " + item.userRating
        cell?.label7.text = item.link
        cell?.imagelabel.image = str2Img(imageStr: item.image)
//        configureText(for: cell, with: item)
//        configureImage(for: cell, with: item)
//
        return cell!
    }

}



extension SearchMovie: (SearchTabelViewprotocol){
    
    func onClickCell(index: Int) {
        print(searchResult[index].title + " is clicked")
        var find:Bool = false
        for iteminlist in mymovielist{
            if iteminlist.title == searchResult[index].title {
                find = true
                break
            }
        }
            if find {
                alert(title: "추가 실패!", message: "이미 본 영화 목록에 추가되어 있어요!", text: "c")
            }
            else{
                mymovielist.append(searchResult[index])
                 alert(title: "목록에 추가 성공!", message: "본영화 목록에 성공적으로 추가 되었어요!", text: "c")
            }
        }

        
    
    func alert(title:String, message: String, text: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
    alert.addAction(okButton)
    return self.present(alert, animated:true, completion: nil)}
    
    }
    


    
//    let newitem = searchResult[index]
//        newitem.saveItem()
        

 
//        print(searchResult[index].image)
//        UserDefaults.standard.set(mymovielist, forKey: "mymovielist")
//        for i in 0...mymovielist.count-1{
//            print(mymovielist[i].title)
//        }
        
//        listname.append(searchResult[index])
        
//        savedlist.setProperty(_property: searchResult[index].title)
//        print(savedlist.getproperty)

    //    func configureText(for cell: UITableViewCell, with item: movieList) {
    //        if let label1 = cell.viewWithTag(1001) as? UILabel {
    //            label1.text = item.title
    //        }
    //        if let label2 = cell.viewWithTag(1002) as? UILabel {
    //            label2.text = item.subtitle
    //        }
    //        if let label3 = cell.viewWithTag(1003) as? UILabel {
    //            label3.text = "pubDate: " + item.pubDate
    //        }
    //        if let label4 = cell.viewWithTag(1004) as? UILabel {
    //            label4.text = "director: " + item.director
    //        }
    //        if let label5 = cell.viewWithTag(1005) as? UILabel {
    //            label5.text = "actor: " + item.actor
    //        }
    //        if let label6 = cell.viewWithTag(1006) as? UILabel {
    //            label6.text = "user rating: " + item.userRating
    //        }
    //        if let label7 = cell.viewWithTag(1007) as? UILabel {
    //            label7.text = item.link
    //        }
    //    }
    //
    //    func configureImage(for cell: UITableViewCell, with item: movieList) {
    //        if let label = cell.viewWithTag(10) as? UIImageView {
    //            label.image = str2Img(imageStr: item.image)
    //    }
    

