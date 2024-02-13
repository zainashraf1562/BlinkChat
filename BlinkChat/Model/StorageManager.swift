//
//  StorageManager.swift
//  BlinkChat
//
//  Created by Zain Ashraf on 1/23/24.
//

import Foundation
import FirebaseStorage

class StorageMangager {
    static let base = StorageMangager()
    
    private let storage = Storage.storage().reference()
    
    func storePicture(with data: Data, fileName: String, completionHandler: @escaping(String) -> Void){
        storage.child("profileImages/\(fileName)").putData(data, metadata: nil, completion: {metadata,error in
            if let e = error {
                print("putDataERROR\(e)")
            }else{
                self.storage.child("profileImages/\(fileName)").downloadURL(completion: { url, error in
                    if let e = error {
                        print("downloadURLERROR\(e)")
                    }else{
                        let urlString = url?.absoluteString
                        completionHandler(urlString!)
                    }
                })
            }
        })
    }
    
    func storeImage(with data: Data, fileName: String, completionHandler: @escaping(String) -> Void){
        storage.child("messageImages/\(fileName)").putData(data, metadata: nil, completion: {metadata,error in
            if let e = error {
                print("putDataERROR\(e)")
            }else{
                self.storage.child("messageImages/\(fileName)").downloadURL(completion: { url, error in
                    if let e = error {
                        print("downloadURLERROR\(e)")
                    }else{
                        completionHandler((url?.absoluteString)!)
                    }
                })
            }
        })
    }
    
    func getURL(for path: String, completionHandler: @escaping (URL?) -> Void) {
        let reference = storage.child(path)
        print(path)
        reference.downloadURL(completion: { url, error in
            if let e = error {
                print("downloadURLERROR\(e)")
            }else{
                completionHandler(url)
            }
        })
    }
    func getImage(_ url:URL) async throws ->Data{
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode==200 else{
            throw NetworkError.invalidResponse
        }
        
        return data
    }
    
}
enum NetworkError:Error{
    case invalidResponse
    case invalidData
}
