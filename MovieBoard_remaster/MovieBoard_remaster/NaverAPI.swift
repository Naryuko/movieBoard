//
//  NaverAPI.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import Foundation

class NaverAPI {
    
    var movieList: [MovieList] = []
    var errorMessage = ""
    
    func search(for search: String, completion: @escaping ([MovieList]?, String) -> ()) {
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
                      completion(self.movieList, self.errorMessage)
                    }
                }
            }
        }
            
        task.resume()
    }
    
    
    func updateResult(_ data: Data) {
        movieList.removeAll()
        
        do {
            let totalData = try JSONDecoder().decode(TotalData.self, from: data)
            let count = totalData.items.count
            
            if count == 0 {
                print("error")
            } else {
                for i in (0...count-1) {
                    let title = totalData.items[i].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let link = totalData.items[i].link
                    let image = totalData.items[i].image
                    let subtitle = totalData.items[i].subtitle.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let pubDate = totalData.items[i].pubDate
                    let director = totalData.items[i].director
                    let actor = totalData.items[i].actor
                    let userRating = totalData.items[i].userRating
                    movieList.append(MovieList(id: i, title:title, link: link, image: image, subtitle: subtitle, pubDate: pubDate, director: director, actor: actor, userRating: userRating, comment: ""))
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    
}
