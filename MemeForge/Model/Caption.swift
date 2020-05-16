//
//  Caption.swift
//  MemeForge
//
//  Created by APPLE on 10/15/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import Foundation

struct Caption {
    var id: Int
    var message: String
    var locationX: Double
    var locationY: Double
    
    init(id: Int, message: String, locationX: Double, locationY: Double) {
        self.id = id
        self.message = message
        self.locationX = locationX
        self.locationY = locationY
    }
}
