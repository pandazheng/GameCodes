//
//  GameScene.swift
//  KickBall
//
//  Created by pandazheng on 15/7/5.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import SpriteKit

let MASK_EDGE : UInt32 = 0b1
let MASK_BALL : UInt32 = 0b10
let MASK_FLAG : UInt32 = 0b100

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var gameStarted : Bool!
    var ball : SKSpriteNode!
    var myLabel : SKLabelNode!
    
    override func didMoveToView(view: SKView) {

        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        physicsBody?.contactTestBitMask = MASK_EDGE
        
        physicsWorld.contactDelegate = self
        
        ball = childNodeWithName("ball") as! SKSpriteNode
        myLabel = childNodeWithName("myLabel") as! SKLabelNode
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 20;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
//        myLabel.physicsBody = SKPhysicsBody(rectangleOfSize: myLabel.frame.size)
        
//        self.addChild(myLabel)
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
        
        if (gameStarted != nil) {
            
            var flag = SKSpriteNode(imageNamed: "flag1")
            addChild(flag)
            flag.physicsBody = SKPhysicsBody(rectangleOfSize: flag.frame.size)
            flag.position = (touches as NSSet).anyObject()!.locationInNode(self)
            flag.physicsBody?.contactTestBitMask = MASK_FLAG
            flag.physicsBody?.velocity = CGVector(dx: 0,dy: 500)
        }
        else
        {
            gameStarted = true
            myLabel.hidden = true
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody?.contactTestBitMask = MASK_BALL
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //println(">>>>>")
        let maskCode = contact.bodyA.contactTestBitMask | contact.bodyB.contactTestBitMask
        if maskCode == MASK_EDGE | MASK_FLAG {
            if contact.bodyA.contactTestBitMask == MASK_FLAG {
                contact.bodyA.node?.removeFromParent()
            }
            if contact.bodyB.contactTestBitMask == MASK_FLAG {
                contact.bodyB.node?.removeFromParent()
            }
        } else if maskCode == MASK_EDGE | MASK_BALL {
            //println("Game Over......")
            
            self.view?.presentScene(GameOver(size: self.frame.size))
        }
    }
    
    
}
