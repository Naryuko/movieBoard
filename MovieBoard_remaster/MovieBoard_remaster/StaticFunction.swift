//
//  StaticFunction.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import Foundation
import UIKit

struct Function {
    static func str2img (from imageStr: String) -> UIImage? {
        if let imageURL = URL(string: imageStr) {
            do {
                let imageData = try Data(contentsOf: imageURL)
                return UIImage(data: imageData)
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    
}
