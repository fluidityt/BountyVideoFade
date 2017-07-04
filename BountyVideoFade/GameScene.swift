//
//  GameScene.swift
//  BountyVideoFade
//
//  Created by justin fluidity on 7/4/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit
import MediaPlayer



    class GameScene: SKScene {
      
      let videoNode = SKVideoNode(fileNamed: "sample.mp4")
      
      override func didMove(to view: SKView) {
        removeAllChildren() // Delete this in your actual project.
        
        addChild(videoNode)
        
        videoNode.alpha = 0
        videoNode.play()
        videoNode.run(.fadeIn(withDuration: 5))
      }
      
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gGVC.setVolumeStealthily(0)
      }
      
      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gGVC.setVolumeStealthily(1)
      }
    }
