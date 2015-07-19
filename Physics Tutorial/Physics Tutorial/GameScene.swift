//
//  GameScene.swift
//  Physics Tutorial
//
//  Created by panda zheng on 15/7/20.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None : UInt32 = 0      //0
    static let Square : UInt32 = 0b1  //1
    static let Ball : UInt32 = 0b10   //2
    static let Border : UInt32 = 0b100 //4
    static let All : UInt32 = UInt32.max
}

class GameScene: SKScene , SKPhysicsContactDelegate{
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        physicsWorld.contactDelegate = self
        
        let sceneBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        self.physicsBody?.categoryBitMask = PhysicsCategory.Border
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None
        
        var spriteNode = SKSpriteNode(imageNamed: "Spaceship")
        spriteNode.size = CGSize(width: 180, height: 180)
        spriteNode.position = CGPoint(x:self.frame.size.width/2,y:self.frame.size.height/2)
        spriteNode.physicsBody = SKPhysicsBody(rectangleOfSize: spriteNode.size)
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.dynamic = false
        spriteNode.physicsBody?.categoryBitMask = PhysicsCategory.Square
        spriteNode.physicsBody?.collisionBitMask = PhysicsCategory.None
        spriteNode.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        self.addChild(spriteNode)
        
        var rotateAction = SKAction.rotateByAngle(CGFloat(M_PI), duration: 10)
        spriteNode.runAction(SKAction.repeatActionForever(rotateAction))
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch : AnyObject in (touches as! Set<UITouch>) {
            var positionOfTouch = touch.locationInNode(self)
            
            var ball = SKShapeNode(circleOfRadius: 25)
            ball.fillColor = SKColor.redColor()
            ball.position = positionOfTouch
            
            ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
            ball.physicsBody?.affectedByGravity = true
            ball.physicsBody?.restitution = 1
            ball.physicsBody?.linearDamping = 0
            ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
            ball.physicsBody?.collisionBitMask = PhysicsCategory.Border | PhysicsCategory.Ball
            ball.physicsBody?.contactTestBitMask = PhysicsCategory.Square
            addChild(ball)
        }
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
        
        if ((contactBody1.categoryBitMask == 1) && (contactBody2.categoryBitMask == 2)) {
            contactBody2.node!.removeFromParent()
        }
    }
    
}
