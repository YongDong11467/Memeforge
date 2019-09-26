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
}
