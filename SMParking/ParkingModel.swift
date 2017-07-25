//
//  ParkingModel.swift
//  SMParking
//
//  Created by Aaron Manill on 4/25/17.
//  Copyright © 2017 Aaron Manill. All rights reserved.
//

import Foundation

class ParkingModel {
    static func getAllLots(url: String, completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the url that we will be sending the GET Request to
        let urls = URL(string: url)
        // Create a URLSession to handle the request tasks
        var urlrequest = URLRequest(url: urls!)
        urlrequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(urlrequest)
        print(urlrequest.allHTTPHeaderFields!)
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: urlrequest, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
    }
    
    static func getRoute(url: String, completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the url that we will be sending the GET Request to
        let urls = URL(string: url)
        // Create a URLSession to handle the request tasks
        var urlrequest = URLRequest(url: urls!)
        urlrequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(urlrequest)
        print(urlrequest.allHTTPHeaderFields!)
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: urlrequest, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
    }
}
