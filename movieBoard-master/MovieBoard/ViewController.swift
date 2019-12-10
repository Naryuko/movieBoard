//
//  ViewController.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/12.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit

    
class ViewController :UICollectionViewController {

    var testitems = ["a","b","c"] // This is the test item
    
//    @IBAction func reload(_ sender: Any) {
//        self.collectionView.reloadData()}
// manual reload button
    
    @IBAction func testbutton(_ sender: Any) {
        UserDefaults.standard.set(mymovielist, forKey: "mymovielist")
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
        // After add list and you back, reload(refresh) main page
    }
    override func viewDidLoad() {
        
      
        super.viewDidLoad()
         self.collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }

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
    

