//
//  ServiceManager.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/18/20.
//

import Foundation

// Check how we can do it in Obj-c
// Advantages and Disadvantages of Singleton
// JSONSerialization converts data to dictionary or array
// https://api.openweathermap.org/data/2.5/weather?id=4276614&appid=0f7e07a9d99396dcf15d793331c720b8
// https://www.googleapis.com/books/v1/volumes?q=coding

class ServiceManager {
    
    // MARK: Singleton pattern
    static let manager = ServiceManager()
    private init() { }
    
    // MARK: URL Session to get data from server
    func request(withUrl url: URL, completionHandler:@escaping (Any?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // All 3 (data, response, error) are optional type
            // Response keeps complete server and url-headers related information
            
            guard let httpResponse = response as? HTTPURLResponse, (
                    httpResponse.statusCode == 200), let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            //let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        }
        task.resume() // In order to call the service
    }
}
