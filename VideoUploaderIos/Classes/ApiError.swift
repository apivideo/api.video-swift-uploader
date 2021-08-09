//
//  Response.swift
//  sdkApiVideo
//
//  Created by romain PETIT on 16/12/2019.
//  Copyright © 2019 Romain. All rights reserved.
//

import Foundation

public struct ApiError: Codable{
    public var url: String?
    public var statusCode: String?
    public var message: String?
    
    public init(url: String?, statusCode: String?, message: String?) {
        self.url = url
        self.statusCode = statusCode
        self.message = message
    }
    
    enum CodingKeys : String, CodingKey {
        case url = "type"
        case statusCode = "status"
        case message = "title"
    }
    
}
