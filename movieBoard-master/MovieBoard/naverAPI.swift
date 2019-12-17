//
//  naverAPI.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/24.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation

class naverAPI {
    
    typealias QueryResult = ([movieList]?,String) -> ()
    var MovieList: [movieList] = []
    var errorMessage = ""
    
    func search(for search: String, completion: @escaping QueryResult) {
        let ClientID = "IgiH9YNGmaJBAxtYJq8i"
        let ClientSecret = "u_cak9Eqog"

        let url = "https://openapi.naver.com/v1/search/movie.json?query="
        let query = url + search

        let encoded = query.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)

        var request = URLRequest(url: URL(string: encoded!)!)
        request.httpMethod = "GET"
        request.addValue(ClientID,forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(ClientSecret,forHTTPHeaderField: "X-Naver-Client-Secret")

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data {
                    self.updateResult(data)
                    DispatchQueue.main.async {
                      completion(self.MovieList, self.errorMessage)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
            
            
        task.resume()
    }
    
    
    func updateResult(_ data: Data) {
        MovieList.removeAll()
        do {
            let aaa = try JSONDecoder().decode(totalData.self, from: data)
            let count = aaa.items.count
            if count == 0 {
                print("error")
            } else {
                for i in (0...count-1) {
                    let title = aaa.items[i].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let link = aaa.items[i].link
                    let image = aaa.items[i].image
                    let subtitle = aaa.items[i].subtitle.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let pubDate = aaa.items[i].pubDate
                    let director = aaa.items[i].director
                    let actor = aaa.items[i].actor
                    let userRating = aaa.items[i].userRating
                    MovieList.append(movieList(title:title, link: link, image: image, subtitle: subtitle, pubDate: pubDate, director: director, actor: actor, userRating: userRating, comment: ""))
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
