//
//  GameScene.swift
//  SpaceMonkey
//
//  Created by Main Account on 4/10/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import SpriteKit

enum BodyType: UInt32 {
  case player = 1
  case enemy = 2
  case ground = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  let player = SKSpriteNode(imageNamed:"spacemonkey_fly02")
  // 1
  var gameOver = false
  // 2
  let endLabel = SKLabelNode(text: "Game Over")
  let endLabel2 = SKLabelNode(text: "Tap to restart!")
  let touchToBeginLabel = SKLabelNode(text: "Touch to begin!")
  let points = SKLabelNode(text: "0")
  // 3
  var numPoints = 0
  // 4
  let explosionSound = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: true)
  let coinSound = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
  
  override func didMoveToView(view: SKView) {
    
    player.position = CGPoint(x:frame.size.width * 0.1, y: frame.size.height * 0.5)
    addChild(player)
    backgroundColor = SKColor.blackColor()
    
    player.physicsBody = SKPhysicsBody(circleOfRadius:player.frame.size.width * 0.3)
    player.physicsBody?.allowsRotation = false
    
    let collisionFrame = CGRectInset(frame, 0, -self.size.height * 0.2)
    physicsBody = SKPhysicsBody(edgeLoopFromRect: collisionFrame)
    physicsWorld.contactDelegate = self
    
    physicsBody?.categoryBitMask = BodyType.ground.rawValue
    
    player.physicsBody?.categoryBitMask = BodyType.player.rawValue
    player.physicsBody?.contactTestBitMask = BodyType.enemy.rawValue
    player.physicsBody?.collisionBitMask = BodyType.ground.rawValue
    
    setupLabels()
    
    player.physicsBody?.dynamic = false
    
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  func random(#min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }
  
  func spawnEnemy() {
    let enemy = SKSpriteNode(imageNamed: "boss_ship")
    enemy.name = "enemy"
    enemy.position = CGPoint(x: frame.size.width + enemy.size.width/2,
      y: frame.size.height * random(min: 0, max: 1))
    addChild(enemy)
    
    enemy.runAction(
      SKAction.moveByX(-size.width - enemy.size.width, y: 0.0,
        duration: NSTimeInterval(random(min: 1, max: 2))))
    
    // 1
    enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width/4)
    // 2
    enemy.physicsBody?.dynamic = false
    // 3
    enemy.physicsBody?.affectedByGravity = false
    // 4
    enemy.physicsBody?.allowsRotation = false
    // 5
    enemy.physicsBody?.categoryBitMask = BodyType.enemy.rawValue
    // 6
    enemy.physicsBody?.contactTestBitMask = BodyType.player.rawValue
    // 7
    enemy.physicsBody?.collisionBitMask = 0
    
  }
  
  func jumpPlayer() {
    // 1
    let impulse =  CGVector(dx: 0, dy: 75)
    // 2
    player.physicsBody?.applyImpulse(impulse)
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    // 1
    if (!gameOver) {
      if player.physicsBody?.dynamic == false {
        player.physicsBody?.dynamic = true
        touchToBeginLabel.hidden = true
        backgroundColor = SKColor.blackColor()
        
        runAction(SKAction.repeatActionForever(
          SKAction.sequence([
            SKAction.runBlock(spawnEnemy),
            SKAction.waitForDuration(1.0)])))
      }
      // 2
      jumpPlayer()
      
    }
      // 3
    else if (gameOver) {
      let newScene = GameScene(size: size)
      newScene.scaleMode = scaleMode
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      view?.presentScene(newScene, transition: reveal)
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    //1
    if !gameOver {
      //2
      if player.position.y <= 0 {
        endGame()
      }
      //3
      enumerateChildNodesWithName("enemy") {
        enemy, _ in
        //4
        if enemy.position.x <= 0 {
          //5
          self.updateEnemy(enemy)
        }
      }
    }
  }
  
  func updateEnemy(enemy: SKNode) {
    //1
    if enemy.position.x < 0 {
      //2
      enemy.removeFromParent()
      //3
      runAction(coinSound)
      //4
      numPoints++
      //5
      points.text = "\(numPoints)"
    }
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    switch(contactMask) {
    case BodyType.player.rawValue | BodyType.enemy.rawValue:
      let secondNode = contact.bodyB.node
      secondNode?.removeFromParent()
      let firstNode = contact.bodyA.node
      firstNode?.removeFromParent()
      endGame()
    default:
      return
    }
  }
  
  func setupLabels() {
    // 1
    touchToBeginLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
    touchToBeginLabel.fontColor = UIColor.whiteColor()
    touchToBeginLabel.fontSize = 50
    addChild(touchToBeginLabel)
    
    // 2
    points.position = CGPoint(x: frame.size.width/2, y: frame.size.height * 0.1)
    points.fontColor = UIColor.whiteColor()
    points.fontSize = 100
    addChild(points)
  }
  
  func endGame() {
    // 1
    gameOver = true
    // 2
    removeAllActions()
    // 3
    runAction(explosionSound)
    
    // 4
    endLabel.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
    endLabel.fontColor = UIColor.whiteColor()
    endLabel.fontSize = 50
    endLabel2.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2 + endLabel.fontSize)
    endLabel2.fontColor = UIColor.whiteColor()
    endLabel2.fontSize = 20
    points.fontColor = UIColor.whiteColor()
    addChild(endLabel)
    addChild(endLabel2)
  }
  
}