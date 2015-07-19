//
//  SecondScene.swift
//  Scenes Tutorial
//
//  Created by panda zheng on 15/7/19.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import Foundation
import SpriteKit

class SecondScene : SKScene {
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.greenColor()
        
        var myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.text = "Scene 2"
        myLabel.fontSize = 70
        myLabel.fontColor = UIColor.blackColor()
        myLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(myLabel)
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let newScene = GameScene(size : self.size)
        newScene.scaleMode = scaleMode
        let reveal = SKTransition.doorsOpenHorizontalWithDuration(1)
        self.view?.presentScene(newScene, transition: reveal)
    }
}
