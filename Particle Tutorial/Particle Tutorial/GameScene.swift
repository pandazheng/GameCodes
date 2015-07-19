//
//  GameScene.swift
//  Particle Tutorial
//
//  Created by panda zheng on 15/7/20.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.magentaColor()
        /* Setup your scene here */
        var rainyPlane = SKSpriteNode(imageNamed: "Spaceship")
        rainyPlane.size = CGSize(width: 260, height: 150)
        rainyPlane.position = CGPoint(x:self.frame.size.width/2,y:self.frame.size.height*0.9)
        self.addChild(rainyPlane)
        
        var rain = SKEmitterNode(fileNamed: "rainParticle.sks")
        rain.position = CGPoint(x: rainyPlane.position.x, y: rainyPlane.position.y - rainyPlane.size.height/2)
        addChild(rain)
    }
    

}
