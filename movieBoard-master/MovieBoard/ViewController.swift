//
//  ViewController.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/12.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

// 싱글톤으로 영화리스트 변수 생성

class Singleton
{
    static let shared: Singleton = {
        var instance = Singleton()      
        instance.mymovielist = []
        instance.wanttoseelist = []
        instance.samplelist = []
        instance.numset = 3
        
        let sample1 = movieList(title: "샘플1", link: "샘플", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1153/115317_P01_183558.jpg", subtitle: "샘플", pubDate: "샘플", director: "샘플", actor: "샘플", userRating: "샘플", comment: "샘플")
        let sample2 = movieList(title: "샘플2", link: "샘플", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1153/115317_P01_183558.jpg", subtitle: "샘플", pubDate: "샘플", director: "샘플", actor: "샘플", userRating: "샘플", comment: "샘플")
        let sample3 = movieList(title: "샘플3", link: "샘플", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1153/115317_P01_183558.jpg", subtitle: "샘플", pubDate: "샘플", director: "샘플", actor: "샘플", userRating: "샘플", comment: "샘플")
        instance.samplelist = [sample1, sample2, sample3]
        return instance
    }()
    
    var mymovielist:[movieList] = []
    var wanttoseelist:[movieList] = []
    var samplelist:[movieList] = []
    var numset = 3

}



class ViewController :UICollectionViewController {
    
    //셀에서 보여줄 포스터리스트
    
    var itemlist:[movieList] = Singleton.shared.mymovielist
  
    
    @IBOutlet weak var select: UISegmentedControl!
    
    @IBOutlet weak var selectviewnumber: UISegmentedControl!
    
    //본영화와 볼영화 선택버튼
    @IBAction func changeview(_ sender: UISegmentedControl) {
        if select.selectedSegmentIndex == 0 {
            itemlist = Singleton.shared.mymovielist
            if self.itemlist.count == 0 {
              itemlist = Singleton.shared.samplelist
              }
            self.collectionView.reloadData()
            print("reloaded")
        }
        else if select.selectedSegmentIndex == 1 {
            itemlist = Singleton.shared.wanttoseelist
            if self.itemlist.count == 0 {
              itemlist = Singleton.shared.samplelist
              }
            self.collectionView.reloadData()
            print("reloaded")
        }
    }
    
    //열 선택버튼
    @IBAction func changeviewnum(_ sender: Any) {
        
        if selectviewnumber.selectedSegmentIndex == 0 {
            
            Singleton.shared.numset = 2
            self.collectionView.reloadData()
            print("reloaded1")
            
        }
            
        else if selectviewnumber.selectedSegmentIndex == 1 {
            
            Singleton.shared.numset = 3
            self.collectionView.reloadData()
            print("reloaded2")
            
        }
            
        else if selectviewnumber.selectedSegmentIndex == 2 {
            
            Singleton.shared.numset = 4
            self.collectionView.reloadData()
            print("reloaded3")
            
    }

    }
    
    //다용도 테스트버튼
    
    @IBAction func testbutton(_ sender: Any) {

        
        
        print("Test start")
        Singleton.shared.mymovielist=[]
        Singleton.shared.wanttoseelist = []
        DataManager.delet("mymovielist")
        DataManager.delet("wanttoseelist")
//        DataManager.save(Singleton.shared.mymovielist, with: "mymovielist")
//        DataManager.save(Singleton.shared.wanttoseelist, with: "wanttoseelist")
//        print("saved")
//
//        Singleton.shared.mymovielist = DataManager.load("mymovielist", with: type(of: Singleton.shared.mymovielist))
//        print("loaded2")
//        Singleton.shared.wanttoseelist = DataManager.load("wanttoseelist", with: type(of: Singleton.shared.wanttoseelist))
//        print("loaded2")
//        print(Singleton.shared.mymovielist.count)
//        print(Singleton.shared.samplelist.count)
        
        print("Test done")
    }
    
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    @IBAction func goSearchMovie(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SearchMovie", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "SearchMovie")

        navigationController?.pushViewController(viewController, animated: true)
        
//If you press + on the top of screen, SearchMovie screen will appear.
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartFooterCollectionReusableView", for: indexPath)
        // Customize footerView here
        return footerView
        } else if (kind == UICollectionView.elementKindSectionHeader) {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView", for: indexPath)
        // Customize headerView here
        return headerView
    }
        fatalError()}

    override func viewDidLoad() {

        selectviewnumber.selectedSegmentIndex = 1
        //저장된 데이터 로드
        var url = DataManager.getDocumentDirectory().appendingPathComponent("mymovielist", isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path){
            Singleton.shared.mymovielist = DataManager.load("mymovielist", with: type(of: Singleton.shared.mymovielist))
        }
        url = DataManager.getDocumentDirectory().appendingPathComponent("wanttoseelist", isDirectory: false)
               if FileManager.default.fileExists(atPath: url.path){
                   Singleton.shared.wanttoseelist = DataManager.load("wanttoseelist", with: type(of: Singleton.shared.wanttoseelist))
               }
        
        itemlist = Singleton.shared.mymovielist
        
        if self.itemlist.count == 0 {
          itemlist = Singleton.shared.samplelist
          }
        
        print("viewDidload")
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        super.viewDidLoad()
 
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //cannot search while editing
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        itemlist = Singleton.shared.mymovielist
        if self.itemlist.count == 0 {
          itemlist = Singleton.shared.samplelist
          }
        self.collectionView.reloadData()
        
        super.viewWillAppear(animated)
        
        
        //콜랜션뷰 리로드
        
        print("reloaded")
    }
    

        //콜랙션뷰 섹션
        override func numberOfSections(in collectionView: UICollectionView) -> Int {

            return 1

        }


        //콜랙션뷰 셀 개수
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                    if itemlist.count == 0 {
                        return Singleton.shared.samplelist.count
                    }
                        return itemlist.count
                }

    
        //콜랙션뷰 셀 불러오기
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Mycell", for: indexPath) as? CollectionViewCell
            
            if itemlist.count == 0 {
                cell?.cellimage.image = str2Img(imageStr: Singleton.shared.samplelist[indexPath.row].image)
                return cell!
            }
            cell?.cellimage.image = str2Img(imageStr: itemlist[indexPath.row].image)
            cell?.deleteButtonBackground.isHidden = !isEditing
            cell?.delegate = self


                return cell!
        }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
    
   
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if itemlist.count==0 {alert(title: "Add item First!", message: "additemfirst", text: "additemfirst3")
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "SearchMovie", bundle: nil)
            let desVC = storyboard.instantiateViewController(identifier: "detailMovie") as! detailMovie
            
            desVC.itemToEdit.title = itemlist[indexPath.row].title
            desVC.itemToEdit.subtitle = itemlist[indexPath.row].subtitle
            desVC.itemToEdit.director = itemlist[indexPath.row].director
            desVC.itemToEdit.actor = itemlist[indexPath.row].director
            desVC.itemToEdit.pubDate = itemlist[indexPath.row].pubDate
            desVC.itemToEdit.link = itemlist[indexPath.row].link
            desVC.itemToEdit.image = itemlist[indexPath.row].image
            desVC.itemToEdit.comment = itemlist[indexPath.row].comment
            
            desVC.modalPresentationStyle = UIModalPresentationStyle.automatic
            
            self.present(desVC, animated: true, completion: nil)
        }

    }
    
    //메세지팝업창
    func alert(title:String, message: String, text: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        
        return self.present(alert, animated:true, completion: nil)}
    

    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        
        if itemlist[0].title == "샘플1" {
            alert(title:"샘플은 삭제할 수 없어요!", message: "어서 영화 포스터를 추가하세요!", text: "샘플은 삭제할수 없습니다.")
        }
        else {
        super.setEditing(editing, animated: animated)
        searchBarButton.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems{
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                    cell.isEditing = editing }
                }
            }
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
        
}
    
extension ViewController: CollectionViewCellDelegate {
    func delete(cell: CollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            itemlist.remove(at: indexPath.row)
            collectionView?.deleteItems(at: [indexPath])
            if select.selectedSegmentIndex == 0 {
                Singleton.shared.mymovielist.remove(at: indexPath.row)
            } else if select.selectedSegmentIndex == 1 {
                Singleton.shared.wanttoseelist.remove(at: indexPath.row)
            }
            DataManager.save(Singleton.shared.mymovielist, with: "mymovielist")
            DataManager.save(Singleton.shared.wanttoseelist, with: "wanttoseelist")
        }
    }
}

//핀터레스트
extension ViewController: PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        print(indexPath.row)
        print(itemlist.count)
        if itemlist.count == 0 {
            let photos = str2Img(imageStr: Singleton.shared.samplelist[0].image)!
            return photos.size.height
        }
        let photos = str2Img(imageStr: itemlist[indexPath.row].image)!
        return photos.size.height
    }
    
    
}

