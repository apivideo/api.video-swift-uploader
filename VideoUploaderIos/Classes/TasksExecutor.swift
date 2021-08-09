//
//  TasksExecutor.swift
//  sdkApiVideo
//
//  Created by Romain Petit on 11/02/2021.
//  Copyright © 2021 Romain. All rights reserved.
//

import Foundation
public class TasksExecutor{
    private let decoder = JSONDecoder()
    public func execute(session: URLSession, request: URLRequest, group: DispatchGroup?, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()){

        var task: URLSessionTask?
        task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            let httpResponse = response as? HTTPURLResponse
            if(data == nil && error != nil) {
                completion(nil, ApiError(url: "", statusCode: nil, message: error?.localizedDescription))
                return;
            }
            var json: Dictionary<String, AnyObject>? = nil
            if(data != nil) {
                let deserialized = try? JSONSerialization.jsonObject(with: data!)
                if(deserialized != nil) {
                    json = deserialized! as? Dictionary<String, AnyObject>
                }
            }
            switch httpResponse!.statusCode{
            case 200 ... 299:
                task?.cancel()
                completion(json ?? nil, nil)
            default:
                if(json != nil){
                    let stringStatus = String(json!["status"] as? Int ?? httpResponse!.statusCode)
                    let resp = ApiError(url: json!["type"] as? String, statusCode: stringStatus, message: json!["title"] as? String)
                    task?.cancel()
                    completion(nil, resp)
                }
            }
            if(group != nil){
                group!.leave()
            }
        })
        task!.resume()
    }
    public func execute(session: URLSession, request: URLRequest, completion: @escaping (Dictionary<String, AnyObject>?, ApiError?) -> ()){
        execute(session: session, request: request, group: nil){(data, response) in
            completion(data, response)
        }
    }
}
