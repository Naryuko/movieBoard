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
    var itemToEdit: movieList = movieList(title: "", link: "", image: "", subtitle: "", pubDate: "", director: "", actor: "", userRating: "", comment: "")
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
    
    
    @IBAction func textFieldChange(_ sender: UITextField) {
        if sender.text == nil {
            itemToEdit.comment = ""
        } else {
            itemToEdit.comment = sender.text!
            print(itemToEdit.comment)
        }
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
        if item.comment != "" {
            textfield.text = item.comment
        }
    }
    
    
    func configureImage(with item: movieList) {
        imageL.image = str2Img(imageStr: item.image)
    }
    
    
    @IBAction func addbutton(_ sender: Any) {
        print(itemToEdit.title + " is clicked")
        print(itemToEdit.comment)
        print(itemToEdit.image)
        var find:Bool = false
        var check:Bool = false
        for iteminlist in Singleton.shared.mymovielist{
            if iteminlist.title == itemToEdit.title {
                if iteminlist.comment != itemToEdit.comment {
                    iteminlist.comment = itemToEdit.comment
                    DataManager.save(Singleton.shared.mymovielist, with: "mymovielist")
                    DataManager.save(Singleton.shared.wanttoseelist, with: "wanttoseelist")
                    check = true
                    break
                }
                find = true
                break
            }
        }
        if (find == true) && (check == false) {
            alert(title: "추가 실패!", message: "이미 본 영화 목록에 추가되어 있어요!", text: "c")
        } else if (find == false) && (check == true) {
            alert(title: "변경 완료", message: "이 영화에 대한 comment가 변경되었습니다", text: "c")
        } else if (find == false) && (check == false) {
            Singleton.shared.mymovielist.append(itemToEdit)
            alert(title: "목록에 추가 성공!", message: "본영화 목록에 성공적으로 추가 되었어요!", text: "c")
        }
    }
    
    
    @IBAction func addwanttosee(_ sender: Any) {
        print(itemToEdit.title + " is clicked")
        var find:Bool = false
        var check:Bool = false
        for iteminlist in Singleton.shared.wanttoseelist {
            if iteminlist.title == itemToEdit.title {
                
                if iteminlist.comment != itemToEdit.comment {
                    iteminlist.comment = itemToEdit.comment
                    DataManager.save(Singleton.shared.mymovielist, with: "mymovielist")
                    DataManager.save(Singleton.shared.wanttoseelist, with: "wanttoseelist")
                    check = true
                    break
                }
                
                
                find = true
                break
            }
        }
        if (find == true) && (check == false) {
            alert(title: "추가 실패!", message: "이미 보고싶은 영화 목록에 추가되어 있어요!", text: "c")
        } else if (find == false) && (check == true) {
            alert(title: "변경 완료", message: "이 영화에 대한 comment가 변경되었습니다", text: "c")
        } else if (find == false) && (check == false) {
            Singleton.shared.wanttoseelist.append(itemToEdit)
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
    
    //공유하기버튼//
    @IBAction func shareButton(_ sender: Any) {
        
        //공유할 아이템들//
        let titletoshare: String = itemToEdit.title//제목
        guard let imagetoshare: UIImage = str2Img(imageStr: itemToEdit.image) else {return} //포스터이미지
        let linktoshare: String = itemToEdit.link //링크
        
        let activityController = UIActivityViewController(activityItems: [titletoshare, imagetoshare, linktoshare], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {(nil, completed, _, error)
            in
            if completed {
                print("completed")
                
            }
            else{
                print("cancled")
                
            }
            
    }
    present(activityController, animated: true, completion: nil)
}
}
