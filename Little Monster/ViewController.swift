//
//  ViewController.swift
//  Little Monster
//
//  Created by mitesh soni on 13/06/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    let DIM_ALPHA : CGFloat = 0.2;
    let OPAQUE : CGFloat = 1;
    let MAX_PANELTIES = 3;
    var panelties = 0;
    var timer : NSTimer!;
    var monsterHappy = false;
    var currentItem  : UInt32 = 0;
    
    @IBOutlet var monsterImageView: Monster!
    
    @IBOutlet var panelty1: UIImageView!
    @IBOutlet var panelty2: UIImageView!
    @IBOutlet var panelty3: UIImageView!
    
    @IBOutlet var heartImage: DragImage!
    @IBOutlet var fooImage: DragImage!
    
    var musicPlayer : AVAudioPlayer!
    var sfxSkull : AVAudioPlayer!
    var sfxDeath : AVAudioPlayer!
    var sfxHeart : AVAudioPlayer!
    var sfxBite : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heartImage.dropTarget = monsterImageView;
        fooImage.dropTarget = monsterImageView;
        
        panelty1.alpha = DIM_ALPHA;
        panelty2.alpha = DIM_ALPHA;
        panelty3.alpha = DIM_ALPHA;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!));
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!));
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!));
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!));
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!));
            
            musicPlayer.prepareToPlay();
            musicPlayer.play();
            sfxSkull.prepareToPlay();
            sfxHeart.prepareToPlay();
            sfxDeath.prepareToPlay();
            sfxBite.prepareToPlay();
        } catch let error as NSError{
            print(error);
        }
        
        startTimer();
    }
    
    func itemDroppedOnCharacter(notif : AnyObject) -> Void {
        print("Item dropped");
        monsterHappy = true;
        startTimer();
        fooImage.alpha = DIM_ALPHA;
        heartImage.alpha = DIM_ALPHA;
        fooImage.userInteractionEnabled = false;
        fooImage.userInteractionEnabled = false;
        
        if (currentItem == 0){
            sfxHeart.play();
        } else{
            sfxBite.play();
        }
    }
    
    func startTimer() -> Void {
        if (timer != nil){
            timer.invalidate();
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "changeGameState", userInfo: nil, repeats: true);
    }
    
    func changeGameState() -> Void {
        
        if (!monsterHappy){
            panelties += 1;
            sfxSkull.play();
            if (panelties == 1){
                panelty1.alpha = OPAQUE;
            } else if (panelties == 2){
                panelty2.alpha = OPAQUE;
            } else if (panelties >= 3){
                panelty3.alpha = OPAQUE;
            } else{
                panelty3.alpha = DIM_ALPHA;
                panelty2.alpha = DIM_ALPHA;
                panelty1.alpha = DIM_ALPHA;
            }
            
            if (panelties >= MAX_PANELTIES){
                gameOver();
            }
        }
        
        let rand = arc4random_uniform(2);
        if (rand == 0){
            fooImage.alpha = DIM_ALPHA;
            fooImage.userInteractionEnabled = false;
            heartImage.alpha = OPAQUE;
            heartImage.userInteractionEnabled = true;
        } else{
            heartImage.alpha = DIM_ALPHA;
            heartImage.userInteractionEnabled = false;
            fooImage.alpha = OPAQUE;
            fooImage.userInteractionEnabled = true
        }
        currentItem = rand;
        monsterHappy = false;
    }
    
    func gameOver() -> Void {
        timer.invalidate();
        monsterImageView.playDeadAnimation();
        sfxDeath.play();
    }
}

