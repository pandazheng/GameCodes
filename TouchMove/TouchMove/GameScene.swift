//
//  GameScene.swift
//  TouchMove
//
//  Created by panda zheng on 15/7/29.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let sprite = SKSpriteNode(imageNamed:"Spaceship")
    let sprite2 = SKSpriteNode(imageNamed: "Spaceship")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = CGPoint(x: frame.width/2, y: frame.height/2)
        self.addChild(sprite)
        
        
        sprite2.xScale = 0.5
        sprite2.yScale = 0.5
        sprite2.position = CGPoint(x: frame.width/4, y: frame.height/4)
        addChild(sprite2)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if sprite.containsPoint(location) {
                sprite.position = location
            }
            else if sprite2.containsPoint(location) {
                sprite2.position = location
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if sprite.containsPoint(location) {
                sprite.position = location
            }
            else if sprite2.containsPoint(location) {
                sprite2.position = location
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        sprite.position = CGPoint(x: frame.width/2, y: frame.height/2)
        sprite2.position = CGPoint(x: frame.width/4, y: frame.height/4)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
