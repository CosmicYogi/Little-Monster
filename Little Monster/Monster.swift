//
//  Monster.swift
//  Little Monster
//
//  Created by mitesh soni on 14/06/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation
import UIKit 
class Monster: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        playIdleAnimaiton();
        //playDeadAnimation();
    }
    
    func playIdleAnimaiton() -> Void {
        self.image = UIImage(named: "idle1.png");
        self.animationImages = nil;
        var imageArray = [UIImage]();
        for var x = 1; x <= 4 ; x += 1{
            let monsterImage = UIImage(named: "idle\(x).png");
            imageArray.append(monsterImage!);
        }
        
        self.animationImages = imageArray;
        self.animationDuration = 0.8;
        self.animationRepeatCount = 0 //Because we don't want to limit repead count
        self.startAnimating();
    }
    
    func playDeadAnimation() -> Void {
        self.image = UIImage(named: "dead1.png");
        self.animationImages = nil;
        var imageArray = [UIImage]();
        for var x = 1 ; x <= 5 ; x += 1{
            let deadImage = UIImage(named: "dead\(x).png");
            imageArray.append(deadImage!);
        }
        self.animationImages = imageArray;
        self.animationRepeatCount = 1;
        self.animationDuration = 1;
        self.startAnimating();
    }
}