//
//  HomeViewController.swift
//  PopcloSignIn
//
//  Created by Jack Ramos on 8/2/21.
//

import UIKit
import AVKit

class HomeViewController: UIViewController {
    
    var videoPlayer:AVQueuePlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    var playerLooper: AVPlayerLooper?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "homebg")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
       
        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //SETUP VIDEO IN background
        
        setUpVideo()
    }
    
    func setUpVideo(){
        //get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "homebg", ofType: "mp4")
        
        guard bundlePath != nil else{
            print("Home Video not found")
            return
        }
        
        //create the URL from it
        
        //let url = URL(fileURLWithPath: bundlePath!)
        
        //create the video player item
        
       // let item = AVPlayerItem(url: url)
        
        //let duration = Int64( ( (Float64(CMTimeGetSeconds(AVAsset(url: url).duration)) *  10.0) - 1) / 10.0 )

        
        //create the player
            // videoPlayer = AVQueuePlayer(playerItem: item)
        
        //create the layer
        //videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //playerLooper = AVPlayerLooper(player: videoPlayer!, templateItem: item,
                                     // timeRange: CMTimeRange(start: CMTime.zero, end: CMTimeMake(value: duration, timescale: 1)) )
        
        //adjust the size and frame(test first)
        //videoPlayerLayer?.frame = CGRect(x: self.view.frame.size.width-550, y: self.view.frame.size.height-1000, width: self.view.frame.size.width+300, height:self.view.frame.size.height+300)
        
        
        //view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //addd it to the view and play it
        
        //videoPlayer?.playImmediately(atRate: 1)
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    


}
