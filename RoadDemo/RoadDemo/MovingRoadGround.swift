//
//  MovingRoadGround.swift
//  RoadDemo
//
//  Created by panda zheng on 15/8/2.
//  Copyright (c) 2015年 panda zheng. All rights reserved.
//

import Foundation
import SpriteKit

class MovingRoadGround : SKSpriteNode {
    
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    
    init(size : CGSize) {
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(20, size.height*2))
        
        for var i = 0 ; i < NUMBER_OF_SEGMENTS ; i++ {
            var segmentColor : UIColor!
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            } else {
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor,size: CGSizeMake(20, self.size.height / CGFloat(NUMBER_OF_SEGMENTS)))
            segment.position = CGPointMake(0, CGFloat(i)*segment.size.height)
            addChild(segment)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        let moveUp = SKAction.moveByX(0, y: -frame.size.height/2, duration: 1.0)
        let resetPosition = SKAction.moveToY(0, duration: 0)
        let moveSequence = SKAction.sequence([moveUp,resetPosition])
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stop() {
        removeAllActions()
    }
}
