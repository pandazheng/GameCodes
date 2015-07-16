//
//  GameScene.swift
//  SpaceShooting
//
//  Created by panda zheng on 15/7/14.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    static let Enemy : UInt32 = 1     //000000000000000000001
    static let Bullet : UInt32 = 2    //000000000000000000010
    static let Player : UInt32 = 3    //000000000000000000100
}


class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var HighScore = Int()
    
    var Score : Int = Int()
    
    var Player = SKSpriteNode(imageNamed: "PlayerGalaga.png")
    
    var ScoreLbl = UILabel()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        if (HighScoreDefault.valueForKey("HighScore") != nil)
        {
            HighScore = HighScoreDefault.valueForKey("HighScore") as! NSInteger
        }
        else
        {
            HighScore = 0
        }
        
        physicsWorld.contactDelegate = self
        
        self.scene?.backgroundColor = UIColor.darkGrayColor()
        //self.scene?.size = CGSize(width: 640, height: 1136)
        self.scene?.size = view.frame.size
        
        self.addChild(SKEmitterNode(fileNamed: "MagicParticle"))
        Player.position = CGPointMake(self.size.width/2, self.size.height/5)
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.categoryBitMask = PhysicsCatagory.Player
        Player.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        Player.physicsBody?.dynamic = false
        
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
        
        self.addChild(Player)
        
        ScoreLbl.text = "\(Score)"
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        ScoreLbl.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        ScoreLbl.textColor = UIColor.whiteColor()
        ScoreLbl.textAlignment = NSTextAlignment.Right
        self.view?.addSubview(ScoreLbl)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        
        if ((firstBody.categoryBitMask == PhysicsCatagory.Enemy) && (secondBody.categoryBitMask == PhysicsCatagory.Bullet) || (firstBody.categoryBitMask == PhysicsCatagory.Bullet) && (secondBody.categoryBitMask == PhysicsCatagory.Enemy))
        {
            CollisionWithBullet(firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
        }
        
        if ((firstBody.categoryBitMask == PhysicsCatagory.Enemy) && (secondBody.categoryBitMask == PhysicsCatagory.Player) || (firstBody.categoryBitMask == PhysicsCatagory.Player) && (secondBody.categoryBitMask == PhysicsCatagory.Enemy))
        {
            CollisionWithPlayer(firstBody.node as! SKSpriteNode, Player: secondBody.node as! SKSpriteNode)
        }
    }
    
    func CollisionWithBullet(Enemy : SKSpriteNode,Bullet : SKSpriteNode)
    {
        Enemy.removeFromParent()
        Bullet.removeFromParent()
        Score++
        
        ScoreLbl.text = "\(Score)"
    }
    
    func CollisionWithPlayer(Enemy : SKSpriteNode,Player : SKSpriteNode)
    {
        var ScoreDefault = NSUserDefaults.standardUserDefaults()
        ScoreDefault.setValue(Score, forKey: "Score")
        ScoreDefault.synchronize()
        
        if (Score > HighScore)
        {
            var HighScoreDefault = NSUserDefaults.standardUserDefaults()
            HighScoreDefault.setValue(Score, forKey: "HighScore")
        }
        Enemy.removeFromParent()
        Player.removeFromParent()
        //self.view?.presentScene(SKScene(fileNamed: "GameOver"))
        self.view?.presentScene(GameOver())
        ScoreLbl.removeFromSuperview()
    }
    
    func SpawnBullets()
    {
        var Bullet = SKSpriteNode(imageNamed: "BulletGalaga.png")
        Bullet.zPosition = -5
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        let action = SKAction.moveToY(self.size.height + 30, duration: 0.8)
        let actionDone = SKAction.removeFromParent()
        Bullet.runAction(SKAction.sequence([action,actionDone]))
        //Bullet.runAction(SKAction.repeatActionForever(action))
        
        Bullet.physicsBody = SKPhysicsBody(rectangleOfSize: Bullet.size)
        Bullet.physicsBody?.categoryBitMask = PhysicsCatagory.Bullet
        Bullet.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        Bullet.physicsBody?.affectedByGravity = false
        Bullet.physicsBody?.dynamic = false
        self.addChild(Bullet)
    }
    
    func SpawnEnemies()
    {
        var Enemy = SKSpriteNode(imageNamed: "EnemyGalaga.png")
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 150
        var SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        let action = SKAction.moveToY(-70, duration: 2.0)
        let actionDone = SKAction.removeFromParent()
        Enemy.runAction(SKAction.sequence([action,actionDone]))
        
        Enemy.physicsBody = SKPhysicsBody(rectangleOfSize: Enemy.size)
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.Bullet
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.dynamic = true
        self.addChild(Enemy)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            Player.position.y = location.y
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            Player.position.y = location.y
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
