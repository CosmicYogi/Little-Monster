//
//  ViewController.swift
//  Little Monster
//
//  Created by mitesh soni on 13/06/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var monsterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var animationImageArray = [UIImage]();
        for (var i = 1 ; i <= 4 ; i += 1){
            var image = (UIImage(named: "idle\(i).png"));
            animationImageArray.append(image!);
        }
        
        monsterImageView.animationImages = animationImageArray;
        monsterImageView.animationRepeatCount = 0;
        monsterImageView.animationDuration = 0.8;
        monsterImageView.startAnimating();
    }
    
    
}

