//
//  Service.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 5/12/21.
//

import Foundation
import CryptoKit

class Service: NSObject {
    
    static let share = Service()
    
    static let ts = String(Date().timeIntervalSince1970)
    static let apiKey = "6e30f0d668ed863355c41dc2c8269bcb"
    static let privateKey = "9a967ebc865d3881f08ce5b062ff1230b34d3296"
    
    private func MD5(data: String) -> String{
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    private func generalDataTask(request: URLRequest,completion: @escaping (Result<[Results], Error>) -> ()) {
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
        
            guard let APIData = data else {
                print("no data found")
                return
            }
            
            do {
                let entity = try JSONDecoder().decode(CharactersList.self, from: APIData)
                guard let statusCode = entity.code, (200..<300) ~= statusCode else {
                    completion(.failure(APIError.statusCodeError))
                  return
                }
                let characters = entity.data?.results ?? []
                
                completion(.success(characters))
                
            }catch let jsonErr {
                completion(.failure(jsonErr))
            }
            
        }.resume()
    }
    
    
    func getCharactersList(offsetList: Int, limitList: Int ,completion: @escaping (Result<[Results], Error>) -> ()) {
        
        let myHash = MD5(data: "\(Service.ts)\(Service.privateKey)\(Service.apiKey)")
        let urlString = EndPoint.baseUrl.rawValue+EndPoint.characters.rawValue
        
        let params = ["ts": Service.ts, "apikey": Service.apiKey, "hash": myHash, "offset": String(offsetList), "limit": String(limitList)] as Dictionary<String,String>
        
       var url = URLComponents(string: urlString)!
        url.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let request = URLRequest(url: url.url! )
        
        generalDataTask(request: request) { (res) in
            switch res {
                
            case .success(let characterList):
                completion(.success(characterList))
            case .failure(_):
                return
            }
        }
    }
    
    func getCharactersDetails(id: Int, completion: @escaping (Result<[Results], Error>) -> ()) {
        
        let myHash = MD5(data: "\(Service.ts)\(Service.privateKey)\(Service.apiKey)")
        let urlString = EndPoint.baseUrl.rawValue+EndPoint.characters.rawValue+"/\(id)"
        
        let params = ["ts": Service.ts, "apikey": Service.apiKey, "hash": myHash] as Dictionary<String,String>
        
       var url = URLComponents(string: urlString)!
        url.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let request = URLRequest(url: url.url! )
        generalDataTask(request: request) { (res) in
            switch res {
                
            case .success(let characterList):
                completion(.success(characterList))
            case .failure(_):
                return
            }
        }
        
    }
    
    
}
