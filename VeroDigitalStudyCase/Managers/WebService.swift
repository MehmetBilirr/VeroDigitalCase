//
//  WebService.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation


struct WebService {
    
    static let shared = WebService()
    init(){}
    
    func request<T:Codable>(request:URLRequest,route:Route,method:Method,parameters:[String:Any]?, completion: @escaping(Result<T,Error>) -> Void ) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                            
            var result: Result<Data,Error>?
            if let data = data {
                guard let response = response as? HTTPURLResponse, response.isResponseOK() else {
                    let error = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(.failure(AppError.randomError(error?.error.message ?? "")))
                    return
                }
                result = .success(data)
                let responseString = String(data:data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is :\n \(responseString)")
                
                
            }else if let error = error {
                result = .failure(error)
                print("The error is : \(error.localizedDescription)")
            }
            
            
            DispatchQueue.main.async {
                
                // TODO decode our result and send back to the user
                self.handleResponse(result: result, completion: completion)
                
            }
        }.resume()
        
        }
    
    private func handleResponse<T:Codable>(result:Result<Data,Error>?,completion: (Result<T,Error>) -> Void){
        
        
        guard let result = result else {
          completion(.failure(AppError.unknownError))
            return}
        
        switch result {

        case .success(let data):

          let decoder = JSONDecoder()
          guard let response = try? decoder.decode(T.self, from: data) else {
            completion(.failure(AppError.errorDecoding))
            return
          }
          completion(.success(response))
        case .failure(let error):
          completion(.failure(error))
        }

    }
}
