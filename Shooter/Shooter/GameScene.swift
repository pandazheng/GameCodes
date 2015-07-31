//
//  GameScene.swift
//  Shooter
//
//  Created by panda zheng on 15/7/30.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    static let Enemy : UInt32 = 0x1 << 0
    static let SmallBall : UInt32 = 0x1 << 1
    static let MainBall : UInt32 = 0x1 << 2
}

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    let MainBall = SKSpriteNode(imageNamed: "Ball")
    
    var EnemyTimer = NSTimer()
    
    var BallNumber = 0
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        backgroundColor = UIColor.whiteColor()
        /* Setup your scene here */
        MainBall.size = CGSize(width: 100, height: 100)
        MainBall.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        MainBall.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        MainBall.colorBlendFactor = 1
        MainBall.zPosition = 1.0
        MainBall.physicsBody = SKPhysicsBody(circleOfRadius: MainBall.size.width / 2)
        MainBall.physicsBody?.categoryBitMask = PhysicsCatagory.MainBall
        MainBall.physicsBody?.collisionBitMask = PhysicsCatagory.Enemy
        MainBall.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        MainBall.physicsBody?.affectedByGravity = false
        MainBall.physicsBody?.dynamic = false
        MainBall.name = "MainBall"
        
        self.addChild(MainBall)
        
        EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("Enemies"), userInfo: nil, repeats: true)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as? SKSpriteNode
        let secondBody = contact.bodyB.node as? SKSpriteNode
        
        if (firstBody != nil && secondBody != nil)
        {
            if ((firstBody!.name == "Enemy") && (secondBody!.name == "SmallBall")) {
                collisionBullet(firstBody!, SmallBall: secondBody!)
            }
            else if ((firstBody!.name == "SmallBall") && (secondBody!.name == "Enemy")) {
                collisionBullet(secondBody!, SmallBall: firstBody!)
            }
            else if ((firstBody!.name == "MainBall") && (secondBody!.name == "Enemy")) {
                println("hello world")
                BallNumber++
                MainBall.size = CGSize(width: 100 + BallNumber, height: 100 + BallNumber)
            }
            else if ((firstBody!.name == "Enemy") && (secondBody!.name == "MainBall")) {
                println("MainBall")
                BallNumber++
                MainBall.size = CGSize(width: 100 + BallNumber, height: 100 + BallNumber)
            }
        }
    }
    
    func collisionBullet(Enemy : SKSpriteNode, SmallBall : SKSpriteNode) {
        Enemy.physicsBody?.dynamic = true
        Enemy.physicsBody?.affectedByGravity = true
        Enemy.physicsBody?.mass = 5.0
        SmallBall.physicsBody?.mass = 5.0
        
        Enemy.removeFromParent()
        SmallBall.removeFromParent()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            
            let SmallBall = SKSpriteNode(imageNamed: "Ball")
            SmallBall.position = MainBall.position
            SmallBall.size = CGSize(width: 20, height: 20)
            SmallBall.zPosition = -1.0
            SmallBall.physicsBody = SKPhysicsBody(circleOfRadius: SmallBall.size.width / 2)
            SmallBall.color = UIColor(red: 0.1, green: 0.85, blue: 0.95, alpha: 1.0)
            SmallBall.colorBlendFactor = 1
            SmallBall.physicsBody?.categoryBitMask = PhysicsCatagory.SmallBall
            SmallBall.physicsBody?.collisionBitMask = PhysicsCatagory.Enemy
            SmallBall.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
            SmallBall.physicsBody?.dynamic = true
            SmallBall.physicsBody?.affectedByGravity = true
            SmallBall.name = "SmallBall"
            
            self.addChild(SmallBall)
            
            var dx = CGFloat(location.x - MainBall.position.x)
            var dy = CGFloat(location.y - MainBall.position.y)
            
            let magnitude = sqrt(dx * dx + dy * dy)
            
            dx /= magnitude
            dy /= magnitude
            
            let vector = CGVector(dx: 25.0 * dx, dy: 25.0 * dy)
            SmallBall.physicsBody?.applyImpulse(vector)
        }
    }
    
    func Enemies() {
        let Enemy = SKSpriteNode(imageNamed: "Ball")
        Enemy.size = CGSize(width: 20, height: 20)
        Enemy.color = UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
        Enemy.colorBlendFactor = 1
        Enemy.zPosition = -1.0
        
        //Physics
        Enemy.physicsBody = SKPhysicsBody(circleOfRadius: Enemy.size.width / 2)
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.SmallBall
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.MainBall
        Enemy.physicsBody?.collisionBitMask = PhysicsCatagory.SmallBall
        Enemy.physicsBody?.collisionBitMask = PhysicsCatagory.MainBall
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.dynamic = true
        Enemy.name = "Enemy"
        
        let RandomPosNumber = arc4random() % 4
        
        switch RandomPosNumber {
        case 0:
            Enemy.position.x = 0
            
            var PositionY = arc4random_uniform(UInt32(frame.size.height))
            Enemy.position.y = CGFloat(PositionY)
            self.addChild(Enemy)
            break
        case 1:
            Enemy.position.y = 0
            
            var PositionX = arc4random_uniform(UInt32(frame.size.width))
            Enemy.position.x = CGFloat(PositionX)
            self.addChild(Enemy)
            break
        case 2:
            Enemy.position.y = frame.size.height
            
            var PositionX = arc4random_uniform(UInt32(frame.size.width))
            Enemy.position.x = CGFloat(PositionX)
            self.addChild(Enemy)
            break
        case 3:
            Enemy.position.x = frame.size.width
            
            var PositionY = arc4random_uniform(UInt32(frame.size.height))
            Enemy.position.y = CGFloat(PositionY)
            self.addChild(Enemy)
            break
        default:
            break
        }
        
        Enemy.runAction(SKAction.moveTo(MainBall.position, duration: 3))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
