//
//  Hero.swift
//  DodgeTheSkips
//
//  Created by panda zheng on 15/7/20.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import Foundation
import SpriteKit

class Hero {
    var guy : SKSpriteNode
    var speed = 0.1
    var emit = false
    var emitFrameCount = 0
    var maxEmitFrameCount = 30
    var particles : SKEmitterNode
    
    init (guy: SKSpriteNode,particles: SKEmitterNode) {
        self.guy = guy
        self.particles = particles
    }
}
