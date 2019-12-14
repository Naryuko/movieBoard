import Foundation
import UIKit


func search(for search: String) {
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
                let result = try JSONDecoder().decode(totalData.self, from: data)
                print(result.items[0].title)
            }
        } catch let error as NSError {
            print(error)
        }
    }
        
        
    task.resume()

}






