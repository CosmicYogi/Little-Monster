//
//  ViewController.swift
//  Little Monster
//
//  Created by mitesh soni on 13/06/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let DIM_ALPHA : CGFloat = 0.2;
    let OPAQUE : CGFloat = 1;
    let MAX_PANELTIES = 3;
    var panelties = 0;
    var timer : NSTimer!
    
    
    @IBOutlet var monsterImageView: Monster!
    
    @IBOutlet var panelty1: UIImageView!
    @IBOutlet var panelty2: UIImageView!
    @IBOutlet var panelty3: UIImageView!
    
    @IBOutlet var heartImage: DragImage!
    @IBOutlet var fooImage: DragImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heartImage.dropTarget = monsterImageView;
        fooImage.dropTarget = monsterImageView;
        
        panelty1.alpha = DIM_ALPHA;
        panelty2.alpha = DIM_ALPHA;
        panelty3.alpha = DIM_ALPHA;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer();
    }
    
    func itemDroppedOnCharacter(notif : AnyObject) -> Void {
        print("notification done");
    }
    
    func startTimer() -> Void {
        if (timer != nil){
            timer.invalidate();
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "changeGameState", userInfo: nil, repeats: true);
    }
    
    func changeGameState() -> Void {
        
        panelties += 1;
        
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
    
    func gameOver() -> Void {
        timer.invalidate();
        monsterImageView.playDeadAnimation();
    }
}

