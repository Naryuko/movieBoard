//
//  DataManger.swift
//  MovieBoard
//
//  Created by itct on 2019/12/10.
//  Copyright © 2019 Naryu. All rights reserved.
// 유튜브 데이터저장 영상참고

import Foundation

public class DataManager {
    
    // get Document Directroy
    
    static func getDocumentDirectory () -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else{
            fatalError("Unable to access document directroy")
        }
    }
    
    // save any kind of codable objects
    static func save <T:Encodable> (_ object:T, with fileName:String){
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
                
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
    // Load any kind of codable objects
    static func load <T:Decodable> (_ fileName:String, with type:T.Type) -> T{
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path){
            do{
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch{
                print(url.path)
                fatalError(error.localizedDescription)
            }
        }else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    // load data from a file
    
    static func loadData (_ fileName:String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path){
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path){
            return data
        }else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    
    //load all files from a directroy
    
    static func loadAll <T:Decodable> (_ type:T.Type) -> [T]{
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            
            var modelObjects = [T]()
            
            for fileName in files {
                modelObjects.append(load(fileName, with: type))
            }
            
            return modelObjects
            
        } catch {
            fatalError("Could not load any files")
        }
    }
    
    
    // Delet a file
    static func delet (_ fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
                
            }
        }
    }

}

