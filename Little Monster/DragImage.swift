//
//  DragImage.swift
//  Little Monster
//
//  Created by mitesh soni on 13/06/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation
import UIKit
class DragImage: UIImageView {
    var dropTarget : UIView!;
    
    var originalPosition : CGPoint!;
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center;
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let position = touch.locationInView(self.superview);
            self.center = CGPointMake(position.x, position.y);
            
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.center = originalPosition;
        if let touch = touches.first , let target = dropTarget
            {
                let position = touch.locationInView(self);
                if CGRectContainsPoint(target.frame, position){
                    NSNotificationCenter.defaultCenter().postNotificationName("onTargetDropped", object: nil);
                }
        }
    }
}