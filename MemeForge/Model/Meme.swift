//
//  Meme.swift
//  MemeForge
//
//  Created by APPLE on 9/24/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import Foundation

struct Wrapper: Codable {
    public let success: Bool
    public let data: MemeWrapper
}

struct MemeWrapper: Codable {
    public let memes: [Meme]
}

struct Meme: Codable {
    public let id: String
    public let name: String
    public let url: String
    public let width: Int
    public let height: Int
    public let box_count: Int
    
    init(id: String, name: String, url: String, width: Int, height: Int, box_count: Int) {
        self.id = id
        self.name = name
        self.url = url
        self.width = width
        self.height = height
        self.box_count = box_count
    }
}
