


    import SpriteKit
    import MediaPlayer


    class GameScene: SKScene {
    
      let seekSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 15))
      let volSlider  = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 15))
      
      // Because it takes time for us to load the video, we don't know it's duration,
      // hence we don't know what the `.maximumValue` should be for the seekSlider
      let defaultMax = Float(0.123456789)
      
      var player: AVPlayer!
      var videoNode: SKVideoNode!
      
      func seekSliderChangedValue(sender: UISlider) {
        // Wait for file to finish loading so we can get accurate end duration:
          if sender.maximumValue == defaultMax {
          if CMTimeGetSeconds(player.currentItem!.duration).isNaN { return }
          else { sender.maximumValue = Float(CMTimeGetSeconds(player.currentItem!.duration)) }
        }
        
        let value = CMTimeMake(Int64(seekSlider.value), 1)
        player.seek(to: value)
        player.play()
      }
      
      func volSliderChangedValue(sender: UISlider) {
        player.volume = sender.value
      }
      
      override func didMove(to view: SKView) {
        removeAllChildren()  // Delete this in your actual project.
        
        // Add some labels:
        let seekLabel = SKLabelNode(text: "Seek")
        seekLabel.setScale(3)
        seekLabel.verticalAlignmentMode = .center
        seekLabel.position = CGPoint(x: frame.minX + seekLabel.frame.width/2,
                                     y: frame.maxY - seekLabel.frame.height)
        let volLabel  = SKLabelNode(text: "Volume")
        volLabel.setScale(3)
        volLabel.verticalAlignmentMode = .center
        volLabel.position = CGPoint(x: frame.minX + volLabel.frame.width/2,
                                    y: frame.minY + volLabel.frame.height + volSlider.frame.height)
        
        // Make player and node:
        let url = Bundle.main.url(forResource: "sample", withExtension: "mp4")!
        player = AVPlayer(url: url)
        videoNode = SKVideoNode(avPlayer: player!)
        
        //Configure seek slider:
        seekSlider.addTarget(self, action: #selector(seekSliderChangedValue), for: UIControlEvents.valueChanged)
        seekSlider.maximumValue = defaultMax
        let seekOrigin = convertPoint(toView: CGPoint(x: seekLabel.frame.minX, y: seekLabel.frame.minY))
        seekSlider.frame = CGRect(origin: seekOrigin, size: CGSize(width: 200, height: 15))
        
        //Configure vol slider:
        volSlider.addTarget(self, action: #selector(volSliderChangedValue), for: UIControlEvents.valueChanged)
        volSlider.value = 1
        let volOrigin = convertPoint(toView: CGPoint(x: volLabel.frame.minX, y: volLabel.frame.minY))
        volSlider.frame = CGRect(origin: volOrigin, size: CGSize(width: 200, height: 15))
        
        //Scene stuff:
        view.addSubview(seekSlider)
        view.addSubview(volSlider)
        addChild(seekLabel)
        addChild(volLabel)
        addChild(videoNode)
        
        // Start video and animation:
        videoNode.alpha = 0
        videoNode.play()
        videoNode.run(.fadeIn(withDuration: 5))
      }
    }

