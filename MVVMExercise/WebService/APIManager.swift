//
//  APIHelper.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case responseError
    case parsingError
    case connectionError
}

class APIManager {
    
    static let apiUrl = "https://jsonplaceholder.typicode.com/users"
    public static let shared = APIManager()
    
    private init() {}
    
    func fetchUsersDetail(completionHandler : @escaping (Result<[UserModel],NetworkError>) -> Void) {
        
        //todo : need to check internet
        let urlRequest = URL.init(string: APIManager.apiUrl)!;
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(.failure(.responseError))
                return
            }
            
            do {
                guard let data = data else {
                    return
                }
                let users = try JSONDecoder().decode([UserModel].self, from: data)
                DataManager.shared.setUsers(users: users);
                completionHandler(.success(users))
            } catch {
                completionHandler(.failure(.parsingError))
            }
        }.resume()
    }

    
}
