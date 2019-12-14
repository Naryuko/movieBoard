//
//  ViewController.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/12.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

var mymovielist:[movieList] = []


class ViewController :UICollectionViewController {

//    @IBAction func reload(_ sender: Any) {
//        self.collectionView.reloadData()}
// manual reload button
    
    
    @IBAction func testbutton(_ sender: Any) {
//        DataManager.save(mymovi
    }
    @IBAction func goSearchMovie(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "SearchMovie", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "SearchMovie")

        navigationController?.pushViewController(viewController, animated: true)
        
//If you press + on the top of screen, SearchMovie screen will appear.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            collectionView.reloadData()
        for i in mymovielist{
            DataManager.save(i, with: i.title)
        }
        // After add list and you back, reload(refresh) main page And save the list
    }
    override func viewDidLoad() {

//    var testitems = ["a","b","c"] // This is the test item
//        let mymovielistItem = MyMovieListItem(title: "testtitel", link: "test", image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1871/187157_P01_144536.png", subtitle: "test", pubDate: "test", director: "test", actor: "test", userRating: "test")
//        mymovielistItem.saveItem()
//        print(mymovielistItem.)
        

        mymovielist = [movieList]()
        mymovielist = DataManager.loadAll(movieList.self)

      
        super.viewDidLoad()
         self.collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
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
            return mymovielist.count
// number of collection cell = mymovielist items
        }


        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Mycell", for: indexPath) as? CollectionViewCell
            cell?.cellimage.image = str2Img(imageStr: mymovielist[indexPath.row].image)
//            cell?.cellimage.image = str2Img(imageStr: mymovielist[indexPath.row].image)
//            cell?.label1.text = mymovielist[indexPath.row].title
            
            return cell!
        }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(identifier: "EditMovieViewController") as! EditMovieViewController
        desVC.image = str2Img(imageStr: mymovielist[indexPath.row].image)!
        desVC.ttl = mymovielist[indexPath.row].title
        desVC.pdate = mymovielist[indexPath.row].pubDate
        desVC.direct = mymovielist[indexPath.row].director
        

        
    self.navigationController?.pushViewController(desVC, animated: true)
    }
    
//delete movie

    
    
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
    



//extension ViewController: UICollectionViewDelegateFlowLayout {
//
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
