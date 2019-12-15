//
//  detailMovie.swift
//  MovieBoard
//
//  Created by Naryu on 2019/12/14.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class detailMovie: UIViewController {
    var itemToEdit: movieList = movieList(title: "", link: "", image: "", subtitle: "", pubDate: "", director: "", actor: "", userRating: "")
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var subTitleL: UILabel!
    @IBOutlet weak var pubDateL: UILabel!
    @IBOutlet weak var directorL: UILabel!
    @IBOutlet weak var actorL: UILabel!
    @IBOutlet weak var userRatingL: UILabel!
    @IBOutlet weak var linkL: UILabel!
    @IBOutlet weak var imageL: UIImageView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var linkB: UIButton!
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureText(with: itemToEdit)
        configureImage(with: itemToEdit)
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
    
    func configureText(with item: movieList) {
        titleL.text = item.title
        subTitleL.text = item.subtitle
        pubDateL.text = "개봉일자 : " + item.pubDate
        directorL.text = "감독 : " + item.director
        actorL.text = "배우 : " + item.actor
        userRatingL.text = "관람객 평점 : " + item.userRating
        linkB.setTitle(item.link, for: .normal)
    }
    
    func configureImage(with item: movieList) {
        imageL.image = str2Img(imageStr: item.image)
    }
    
    
    @IBAction func addbutton(_ sender: Any) {
        print(itemToEdit.title + " is clicked")
        print(itemToEdit.image)
        var find:Bool = false
        for iteminlist in mymovielist{
            if iteminlist.title == itemToEdit.title {
                find = true
                break
            }
        }
        if find {
            alert(title: "추가 실패!", message: "이미 본 영화 목록에 추가되어 있어요!", text: "c")
        }
        else{
            mymovielist.append(itemToEdit)
             alert(title: "목록에 추가 성공!", message: "본영화 목록에 성공적으로 추가 되었어요!", text: "c")
        }
    }
    
    
    @IBAction func addwanttosee(_ sender: Any) {
            print(itemToEdit.title + " is clicked")
            var find:Bool = false
            for iteminlist in wanttoseelist {
                if iteminlist.title == itemToEdit.title {
                    find = true
                    break
                }
            }
            if find {
                alert(title: "추가 실패!", message: "이미 보고싶은 영화 목록에 추가되어 있어요!", text: "c")
            }
            else{
                wanttoseelist.append(itemToEdit)
                 alert(title: "목록에 추가 성공!", message: "보고싶은 영화 목록에 성공적으로 추가 되었어요!", text: "c")
            }
    }
    
    func alert(title:String, message: String, text: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        return self.present(alert, animated:true, completion: nil)
        
    }
    
    
    
    @IBAction func openSafariAction(_ sender: Any) {
        guard let url = URL(string: itemToEdit.link), UIApplication.shared.canOpenURL(url) else { return }
     UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

}

