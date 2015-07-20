//
//  BadGuy.swift
//  DodgeTheSkips
//
//  Created by panda zheng on 15/7/20.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import Foundation
import SpriteKit

class BadGuy {
    var speed : Float = 0.0
    var guy : SKSpriteNode
    var currentFrame = 0
    var randomFrame = 0
    var moving = false
    var angle = 0.0
    var range = 2.0
    var yPos = CGFloat()
    
    init(speed:Float,guy:SKSpriteNode) {
        self.speed = speed
        self.guy = guy
        self.setRandomFrame()
    }
    
    func setRandomFrame() {
        var range = UInt32(50)..<UInt32(200)
        self.randomFrame = Int(range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1))
    }
}