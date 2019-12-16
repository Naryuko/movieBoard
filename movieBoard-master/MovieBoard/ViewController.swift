//
//  ViewController.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/12.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

var mymovielist:[movieList] = []
var wanttoseelist:[movieList] = []
var sample:[movieList] = []



class ViewController :UICollectionViewController {

//    @IBAction func reload(_ sender: Any) {
//        self.collectionView.reloadData()}
// manual reload button
    
    
    @IBAction func testbutton(_ sender: Any) {

//        for i in mymovielist{
//            DataManager.delet(i.title)}
//
//        mymovielist = []
//
//        for i in mymovielist{
//            print(i.title)
//            DataManager.save(i, with: i.title)}
        print(mymovielist.count)
        print(sample.count)
        print("Test")
    }
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    @IBAction func goSearchMovie(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SearchMovie", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "SearchMovie")

        navigationController?.pushViewController(viewController, animated: true)
        
//If you press + on the top of screen, SearchMovie screen will appear.
        
    }
    

    override func viewDidLoad() {

//    var testitems = ["a","b","c"] // This is the test item
//        let mymovielistItem = MyMovieListItem(title: "testtitel", link: "test", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1871/187157_P01_144536.png", subtitle: "test", pubDate: "test", director: "test", actor: "test", userRating: "test")
//        mymovielistItem.saveItem()
//        print(mymovielistItem.)
        
        
         mymovielist = [movieList]()
         mymovielist = DataManager.loadAll(movieList.self)
        
        wanttoseelist = [movieList]()
        wanttoseelist = DataManager.loadAll(movieList.self)
        
        // 콜랙션뷰 디폴트 샘플이미지

                let sample1 = movieList(title: "샘플1", link: "샘플", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1153/115317_P01_183558.jpg", subtitle: "샘플", pubDate: "샘플", director: "샘플", actor: "샘플", userRating: "샘플")
                let sample2 = movieList(title: "샘플2", link: "샘플", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1153/115317_P01_183558.jpg", subtitle: "샘플", pubDate: "샘플", director: "샘플", actor: "샘플", userRating: "샘플")
                let sample3 = movieList(title: "샘플3", link: "샘플", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1153/115317_P01_183558.jpg", subtitle: "샘플", pubDate: "샘플", director: "샘플", actor: "샘플", userRating: "샘플")
                

            let sample = [sample1, sample2, sample3]
          
        print("viewDidload")
      
        super.viewDidLoad()
 
        
//         self.collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //cannot search while editing
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout{
            layout.delegate = self
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in mymovielist{
            DataManager.save(i, with: i.title)
        }
        for i in wanttoseelist{
            DataManager.save(i, with: i.title)
            
            


        }
        // After add list and you back, reload(refresh) main page And save the list
        self.collectionView.reloadData()
        print("reloaded")
    }
    
//    func loadData(){
//        mymovielist = [MyMovieListItem]()
//        mymovielist = DataManager.loadAll(MyMovieListItem.self) //.sorted
////        collectionView.reloadData()
//    }
    
        override func numberOfSections(in collectionView: UICollectionView) -> Int {

            return 1

        }



        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                    if mymovielist.count == 0 {
                        return sample.count
                    }
                    return mymovielist.count
        // number of collection cell = mymovielist items
                }


        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Mycell", for: indexPath) as? CollectionViewCell
                if mymovielist.count == 0 {
                    cell?.cellimage.image = str2Img(imageStr: sample[indexPath.row].image)
                    return cell!
                }
                cell?.cellimage.image = str2Img(imageStr: mymovielist[indexPath.row].image)
        //            cell?.cellimage.image = str2Img(imageStr: mymovielist[indexPath.row].image)
        //            cell?.label1.text = mymovielist[indexPath.row].title

                return cell!

                
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if mymovielist.count == 0 {
            mymovielist=sample
        }
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(identifier: "EditMovieViewController") as! EditMovieViewController
        desVC.image = str2Img(imageStr: mymovielist[indexPath.row].image)!
        desVC.ttl = mymovielist[indexPath.row].title
        desVC.pdate = mymovielist[indexPath.row].pubDate
        desVC.direct = mymovielist[indexPath.row].director
    self.navigationController?.pushViewController(desVC, animated: true)
    }
    
//delete movie
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        searchBarButton.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems{
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                    cell.isEditing = editing
                }
            }
        }
    }

    
//    cell?.lable1.text = mymovielist[indexPath.row].title
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EditMovieViewController") as? EditMovieViewController
//        vc?.ttl = mymovielist[indexPath.row].title
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
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
            mymovielist.remove(at: indexPath.row)
            
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}

extension ViewController: PinterestLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        print(indexPath.row)
        print(mymovielist.count)
        if mymovielist.count == 0 {
            let photos = str2Img(imageStr: sample[indexPath.row].image)!
            return photos.size.height        }
        let photos = str2Img(imageStr: mymovielist[indexPath.row].image)!
        return photos.size.height
    }
    
    
}


//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var columns:Int = 2
//        let width = Int(collectionView.frame.width) / columns
//
////        return CGSize(width: width, height: width)
//    }
//}
////extension ViewController: UICollectionViewDelegateFlowLayout {
////
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    let padding: CGFloat = 25
//    let collectionCellSize = collectionView.frame.size.width - padding
//
//  return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
//
//   }
//
//}
