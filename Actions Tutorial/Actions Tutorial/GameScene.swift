//
//  GameScene.swift
//  Actions Tutorial
//
//  Created by panda zheng on 15/7/19.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        var spriteNode = SKSpriteNode(imageNamed: "myImage")
        spriteNode.size = CGSize(width: 180, height: 180)
        spriteNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addChild(spriteNode)
        
        var action1 = SKAction.moveTo(CGPoint(x:self.frame.size.width/2,y:self.frame.size.height*0.2), duration: 1)
        var action2 = SKAction.scaleBy(0.5, duration: 0.5)
        var action3 = SKAction.moveTo(CGPoint(x:self.frame.size.width/2,y:self.frame.size.height*0.8), duration: 1)
        var action4 = SKAction.scaleBy(0.5, duration: 0.5)
        var action5 = SKAction.moveTo(CGPoint(x:self.frame.size.width/2,y:self.frame.size.height/2),duration:1)
        var actionSequence = SKAction.sequence([action1,action2,action2.reversedAction(),action3,action2.reversedAction(),action4,action5])
        spriteNode.runAction(actionSequence)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
