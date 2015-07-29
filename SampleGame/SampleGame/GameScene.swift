//
//  GameScene.swift
//  SampleGame
//
//  Created by panda zheng on 15/7/21.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None : UInt32 = 0
    static let Player : UInt32 = 0b1
    static let Ball : UInt32 = 0b10
    static let Border : UInt32 = 0b100
    static let All : UInt32 = UInt32.max
}

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var Player : SKShapeNode!
    var Ball1 : SKShapeNode!
    var Ball2 : SKShapeNode!
    var Ball3 : SKShapeNode!
    var Ball4 : SKShapeNode!
    var countDown = 0
    var gameOver = false
    var gameBegin = false
    
    
    var timer = NSTimer()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor.whiteColor()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Border
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        
        physicsWorld.contactDelegate = self
        
        Player = SKShapeNode(rectOfSize: CGSizeMake(50, 50))
        Player.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        Player.fillColor = SKColor.redColor()
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.frame.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        Player.physicsBody?.contactTestBitMask = PhysicsCategory.Border
        Player.physicsBody?.collisionBitMask = PhysicsCategory.Player
        addChild(Player)
        
        
        addBalls()
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        countDown++
    }
    
    func addBalls() {
        
        Ball1 = SKShapeNode(rectOfSize: CGSizeMake(30, 80))
        Ball1.fillColor = UIColor.greenColor()
        Ball1.position = CGPoint(x: 40, y: 60)
        addChild(Ball1)
        Ball2 = SKShapeNode(rectOfSize: CGSizeMake(130, 20))
        Ball2.position = CGPoint(x: self.frame.width - 70, y: 40)
        Ball2.fillColor = UIColor.magentaColor()
        addChild(Ball2)
        Ball3 = SKShapeNode(rectOfSize: CGSizeMake(60, 60))
        Ball3.position = CGPoint(x: 50, y: self.frame.height - 50)
        Ball3.fillColor = UIColor.blueColor()
        addChild(Ball3)
        Ball4 = SKShapeNode(rectOfSize: CGSizeMake(80, 60))
        Ball4.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 40)
        Ball4.fillColor = UIColor.brownColor()
        addChild(Ball4)
        Ball1.physicsBody = SKPhysicsBody(rectangleOfSize: Ball1.frame.size)
        Ball1.physicsBody?.affectedByGravity = false
        Ball1.physicsBody?.dynamic = false
        Ball1.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        Ball1.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        Ball1.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border
        
        
        Ball2.physicsBody = SKPhysicsBody(rectangleOfSize: Ball1.frame.size)
        Ball2.physicsBody?.affectedByGravity = false
        Ball2.physicsBody?.dynamic = false
        Ball2.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        Ball2.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        Ball2.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border
        
        Ball3.physicsBody = SKPhysicsBody(rectangleOfSize: Ball1.frame.size)
        Ball3.physicsBody?.affectedByGravity = false
        Ball3.physicsBody?.dynamic = false
        Ball3.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        Ball3.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        Ball3.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border
        
        Ball4.physicsBody = SKPhysicsBody(rectangleOfSize: Ball1.frame.size)
        Ball4.physicsBody?.affectedByGravity = false
        Ball4.physicsBody?.dynamic = false
        Ball4.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        Ball4.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        Ball4.physicsBody?.collisionBitMask = PhysicsCategory.Ball | PhysicsCategory.Border
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let anyTouch : AnyObject! = (touches as NSSet).anyObject()
        let location = anyTouch.locationInNode(self)
        
        Player.runAction(SKAction.moveTo(location, duration: 0.1))
        gameBegin = true
        updateBall()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let anyTouch : AnyObject! = (touches as NSSet).anyObject()
        let location = anyTouch.locationInNode(self)
        
        Player.runAction(SKAction.moveTo(location, duration: 0))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var contactBody1 : SKPhysicsBody
        var contactBody2 : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            contactBody1 = contact.bodyA
            contactBody2 = contact.bodyB
        } else {
            contactBody1 = contact.bodyB
            contactBody2 = contact.bodyA
        }
        
        if ((contactBody1.categoryBitMask == 1) && (contactBody2.categoryBitMask == 4)) {
            timer.invalidate()
            println("countDown = \(countDown)")
            //GameOver
            gameOver = true
            self.view?.presentScene(GameOver(size: self.view!.bounds.size, score: countDown))
        }
        
        if ((contactBody1.categoryBitMask == 1) && (contactBody2.categoryBitMask == 2)) {
            timer.invalidate()
            println("countDown = \(countDown)")
            gameOver = true
            self.view?.presentScene(GameOver(size: self.view!.bounds.size, score: countDown))
        }
        

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        if gameBegin {
//            updateBall()
//        }
        if gameOver {
            Ball1.removeAllActions()
            Ball2.removeAllActions()
            Ball3.removeAllActions()
            Ball4.removeAllActions()
        }
        
    }
    
    func updateBall() {
        
        var action1 = SKAction.moveTo(CGPoint(x: self.frame.size.width, y: self.frame.size.height), duration: 1.5)
        var action2 = SKAction.moveTo(CGPoint(x: self.frame.size.width, y: 0), duration: 1.5)
        var action3 = SKAction.moveTo(CGPoint(x: 0, y: self.frame.size.height), duration: 1.5)
        var action4 = SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 1.5)
        var actionSequence1,actionSequence2,actionSequence3,actionSequence4 : SKAction!
        
        var rand = arc4random()%5 + 1
        println("rand = \(rand)")
        switch rand {
        case 1:
            actionSequence1 = SKAction.sequence([action1,action2,action3,action4])
            actionSequence2 = SKAction.sequence([action2,action3,action4,action1])
            actionSequence3 = SKAction.sequence([action3,action4,action1,action2])
            actionSequence4 = SKAction.sequence([action4,action1,action2,action3])
        case 2:
            actionSequence1 = SKAction.sequence([action4,action3,action2,action1])
            actionSequence2 = SKAction.sequence([action2,action1,action3,action4])
            actionSequence3 = SKAction.sequence([action2,action1,action3,action4])
            actionSequence4 = SKAction.sequence([action1,action2,action3,action4])
        case 3:
            actionSequence1 = SKAction.sequence([action2,action3,action4,action1])
            actionSequence2 = SKAction.sequence([action2,action3,action4,action1])
            actionSequence3 = SKAction.sequence([action1,action4,action3,action2])
            actionSequence4 = SKAction.sequence([action2,action1,action4,action3])
        case 4:
            actionSequence1 = SKAction.sequence([action1,action2,action4,action3])
            actionSequence2 = SKAction.sequence([action2,action1,action3,action4])
            actionSequence3 = SKAction.sequence([action3,action4,action1,action2])
            actionSequence4 = SKAction.sequence([action4,action1,action2,action3])
        case 5:
            actionSequence1 = SKAction.sequence([action1,action2,action3,action4])
            actionSequence2 = SKAction.sequence([action3,action2,action4,action1])
            actionSequence3 = SKAction.sequence([action4,action3,action1,action2])
            actionSequence4 = SKAction.sequence([action4,action1,action2,action3])
        default:
            println("no rand")
        }
        
        //Ball1.runAction(actionSequence1)
        Ball1.runAction(SKAction.repeatActionForever(actionSequence1))
        Ball2.runAction(SKAction.repeatActionForever(actionSequence2))
        Ball3.runAction(SKAction.repeatActionForever(actionSequence3))
        Ball4.runAction(SKAction.repeatActionForever(actionSequence4))
    }
}
