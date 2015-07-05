//
//  GameScene.swift
//  MusicDemo
//
//  Created by pandazheng on 15/7/5.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {

    var backgroundMusicPlayer = AVAudioPlayer()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        let bgMusicUrl = NSBundle.mainBundle().URLForResource("love", withExtension: "mp3")
        
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicUrl, error: nil)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
