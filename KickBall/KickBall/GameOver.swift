//
//  GameOver.swift
//  KickBall
//
//  Created by pandazheng on 15/7/5.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import SpriteKit

class GameOver : SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        var label = SKLabelNode()
        label.text = "Game Over"
        label.position = CGPoint(x: size.width/2,y: size.height/2)
        addChild(label)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
