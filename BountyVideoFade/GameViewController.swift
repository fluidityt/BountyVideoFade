//
//  GameViewController.swift
//  BountyVideoFade
//
//  Created by justin fluidity on 7/4/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import MediaPlayer

    // Global access to our gameViewController (not a best practice but effective for testing).
    var gGVC = GameViewController()

    extension UIViewController {
      /* extension is property of Senseful on SO: https://stackoverflow.com/a/44480864/6593818 */
      func setVolumeStealthily(_ volume: Float) {
        guard let view = viewIfLoaded else {
          assertionFailure("The view must be loaded to set the volume with no UI")
          return
        }
        
        let volumeView = MPVolumeView(frame: .zero)
        
        guard let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider else {
          assertionFailure("Unable to find the slider")
          return
        }
        
        volumeView.clipsToBounds = true
        view.addSubview(volumeView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak slider, weak volumeView] in
          slider?.setValue(volume, animated: false)
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak volumeView] in
            volumeView?.removeFromSuperview()
          }
        }
      }
    }


    class GameViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
          
            gGVC = self // Registers our global to this instance.
      
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
