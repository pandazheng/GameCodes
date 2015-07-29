//
//  GameOver.swift
//  SampleGame
//
//  Created by panda zheng on 15/7/23.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver : SKScene {
    
    var score : Int = 0
    
    init(size: CGSize,score : Int) {
        super.init(size: size)
        self.score = score
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.blueColor()
        
        var ScoreLabel = SKLabelNode()
        ScoreLabel.text = String(score)
        ScoreLabel.fontSize = 60
        ScoreLabel.fontColor = UIColor.blackColor()
        ScoreLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(ScoreLabel)
        
        
        var Restart = SKLabelNode()
        Restart.text = "Restart"
        Restart.fontColor = UIColor.greenColor()
        Restart.fontSize = 60
        Restart.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2+100)
        addChild(Restart)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view?.presentScene(GameScene(size: self.size),transition:SKTransition.doorsOpenHorizontalWithDuration(1))
    }
}
