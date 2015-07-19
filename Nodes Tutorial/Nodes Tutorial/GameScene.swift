//
//  GameScene.swift
//  Nodes Tutorial
//
//  Created by panda zheng on 15/7/19.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        var exampleLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        exampleLabelNode.text = "Example Label Node!"
        exampleLabelNode.fontSize = 26
        exampleLabelNode.fontColor = SKColor.magentaColor()
        exampleLabelNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(exampleLabelNode)
        
        
        //var exampleSpriteNode = SKSpriteNode(imageNamed: "xx.jpg")
        var exampleSpriteNode = SKSpriteNode(imageNamed: "myImage")
        exampleSpriteNode.size = CGSize(width: 180, height: 180)
        exampleSpriteNode.anchorPoint = CGPoint(x:0.5,y:0.5)
        exampleSpriteNode.position = CGPoint(x: self.frame.size.width/2,y: self.frame.size.height/2 - 120)
        exampleSpriteNode.zPosition = 100
        exampleSpriteNode.name = "exampleName"
        addChild(exampleSpriteNode)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
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
        }
    }
   
}
