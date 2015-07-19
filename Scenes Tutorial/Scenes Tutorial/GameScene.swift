//
//  GameScene.swift
//  Scenes Tutorial
//
//  Created by panda zheng on 15/7/19.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.redColor()
        
        var myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.text = "Scene 1"
        myLabel.fontSize = 70
        myLabel.fontColor = UIColor.magentaColor()
        myLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let myScene = SecondScene(size: self.size)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.fadeWithDuration(1)
        self.view?.presentScene(myScene, transition: reveal)
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
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
//    }
//   
//    override func update(currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//    }
}
