//
//  searchBar.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/24.
//  Copyright © 2019 Naryu. All rights reserved.
//

import UIKit
import Foundation

extension SearchMovie: UISearchBarDelegate {

  @objc func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if !searchBar.text!.isEmpty {
        NaverAPI.search(for: searchBar.text!) { results, errorMessage in
            if let results = results {
                self.searchResult = results
                self.tableView.reloadData()
                self.tableView.setContentOffset(CGPoint.zero, animated: false)
                print(self.searchResult[0].title)
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
    }
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    view.addGestureRecognizer(tapRecognizer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.removeGestureRecognizer(tapRecognizer)
  }
    
    
}
