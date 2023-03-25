//
//  UserDefaults + Extension.swift
//  VeroDigitalStudyCase
//
//  Created by Mehmet Bilir on 25.03.2023.
//

import Foundation

extension UserDefaults {

    func getCacheModels() -> [TaskResponse]? {
        if let data = data(forKey: "Tasks") {
            do {
                let cachedModel = try JSONDecoder().decode([TaskResponse].self, from: data)
                return cachedModel
            } catch {
                
            }
        }
        
        return nil
    }
    
    func saveModeltoCache(_ cacheModel: [TaskResponse]) {
        do {
            let data = try JSONEncoder().encode(cacheModel)
            set(data, forKey: "Tasks")
            synchronize()
        } catch let encodeError {
            print("Failed to encode countModel ",encodeError)
        }
    }
}
