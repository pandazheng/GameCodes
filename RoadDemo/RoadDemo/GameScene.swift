//
//  GameScene.swift
//  RoadDemo
//
//  Created by panda zheng on 15/8/2.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var movingRoadGround1 : MovingRoadGround!
    var movingRoadGround2 : MovingRoadGround!
    
    override func didMoveToView(view: SKView) {
        //backgroundColor = UIColor(red: 100.0/255.0, green: 185.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        var randomChance = arc4random() % 8
        switch randomChance {
        case 0: backgroundColor = UIColor.blueColor()
        case 1: backgroundColor = UIColor.grayColor()
        case 2: backgroundColor = UIColor.brownColor()
        case 3: backgroundColor = UIColor.greenColor()
        case 4: backgroundColor = UIColor.orangeColor()
        case 5: backgroundColor = UIColor.purpleColor()
        case 6: backgroundColor = UIColor.yellowColor()
        case 7: backgroundColor = UIColor.magentaColor()
        default: break
        }
        
        addMovingRoadGround()
    }
    
    func addMovingRoadGround() {
        movingRoadGround1 = MovingRoadGround(size: CGSizeMake(20, view!.frame.height))
        movingRoadGround1.position = CGPointMake(40, 0)
        addChild(movingRoadGround1)
        
        movingRoadGround2 = MovingRoadGround(size: CGSizeMake(view!.frame.width - 20, view!.frame.height))
        movingRoadGround2.position = CGPointMake(view!.frame.width - 40, 0)
        addChild(movingRoadGround2)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            movingRoadGround1.start()
            movingRoadGround2.start()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
