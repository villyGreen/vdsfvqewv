//
//  ViewController.swift
//  offers
//
//  Created by zz on 22.05.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StartOfferSecondScreen: UIViewController {
    @IBOutlet weak var firstShield: UIButton!
    @IBOutlet weak var secondShield: UIButton!
    var avPlayer: AVPlayer!
    @IBOutlet weak var background: UIView!
    var isChoose = false
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var bottmGradienView: GradientView!
    @IBOutlet weak var gradientView: GradientView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstShield.layer.cornerRadius = 4
        secondShield.layer.cornerRadius = 4
        gradientView.setupBackground(from: .top, to: .bottom, startColor: UIColor.black.withAlphaComponent(0.5), endColor: UIColor.black.withAlphaComponent(0.7))
        bottmGradienView.setupBackground(from: .top, to: .bottom, startColor: UIColor.black.withAlphaComponent(0.7), endColor: .black)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.avPlayer = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp4")!))
            let layer = AVPlayerLayer(player: self.avPlayer)
            layer.frame = self.view.bounds
                           layer.videoGravity = .resizeAspectFill
            self.background.layer.addSublayer(layer)
                              self.avPlayer.play()
    }

    @IBAction func changed(_ sender: UISegmentedControl) {
        
        segmentedControll.setImage(UIImage(named: "Rectangle"), forSegmentAt: isChoose ? 0 : 1)
        segmentedControll.setImage(UIImage(named: " "), forSegmentAt: isChoose ? 1 : 0)
        isChoose.toggle()
        
    }
    
}

