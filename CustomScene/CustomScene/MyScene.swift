//
//  MyScene.swift
//  CustomScene
//
//  Created by pandazheng on 15/7/5.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import SpriteKit

class MyScene : SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        
        
        backgroundColor = UIColor.redColor()
        println(size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(">>>>>>>>>>")
        
        var t: AnyObject = (touches as NSSet).anyObject()!
        println(t)
    }
}

