//
//  LockView.swift
//  Funny
//
//  Created by yanzhen on 16/1/7.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

protocol LockViewProtocol: NSObjectProtocol {
    func lockPasswordString(password: String);
}
class LockView: UIView {

    weak var delegate: LockViewProtocol?
    var btnsArray = [UIButton]()
    var movePoint: CGPoint! = CGPointZero
    
    override func drawRect(rect: CGRect) {
        if btnsArray.count <= 0 {
            return;
        }
        
        let path = UIBezierPath();
        for i in 0 ..< btnsArray.count {
            let btn = btnsArray[i];
            if i == 0 {
                path.moveToPoint(btn.center);
            }else{
                path.addLineToPoint(btn.center);
            }
        }
        path.addLineToPoint(movePoint);
        UIColor.greenColor().set();
        path.lineWidth = 3.0;
        path.lineJoinStyle = CGLineJoin.Round;
        path.stroke();
    }
    
//MARK: - Touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isFirstDraw();
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        let point = touch.locationInView(self);
        let touchButton = self.buttonWithPoint(point);
        if touchButton != nil && touchButton?.selected == false{
            touchButton?.selected = true;
            btnsArray.append(touchButton!);
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches as NSSet;
        let touch = t.anyObject() as! UITouch;
        movePoint = touch.locationInView(self);
        let touchButton = self.buttonWithPoint(movePoint);
        if touchButton != nil && touchButton?.selected == false{
            touchButton?.selected = true;
            btnsArray.append(touchButton!);
        }
        self.setNeedsDisplay();

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isPasswordRight();
    }
    
//MARK: - private
    
    private func isPasswordRight() {
        if btnsArray.count <= 0 {
            return;
        }
        var passwordString = "";
        for (index,_) in btnsArray.enumerate() {
            let btn = btnsArray[index];
            passwordString += String(btn.tag - 10000);
        }
        
        delegate?.lockPasswordString(passwordString);
        self.renewOriginalStatus();
    }
    
    private func isFirstDraw() {
        self.renewOriginalStatus();
    }
    
    private func buttonWithPoint(point: CGPoint) ->UIButton? {
        for (_,value) in self.subviews.enumerate() {
            let btn = value as! UIButton;
            if CGRectContainsPoint(btn.frame, point){
                return btn;
            }
        }
        return nil;
    }
    
//MARK: - UI
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
        self.addBtns();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        var col = 0;
        var row = 0;
        let btnWH = CGFloat(90);
        var btnX = CGFloat(0);
        var btnY = CGFloat(0);
        let space = (self.width - 3 * btnWH) / 4 as CGFloat;
        for i in 0 ..< self.subviews.count {
            col = i % 3;
            row = i / 3;
            let btn = self.subviews[i] as! UIButton;
            btnX = space + (space + btnWH) * CGFloat(col);
            btnY = (space + btnWH) * CGFloat(row) + 20.0;
            btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
        }
    }
    
    private func addBtns() {
        for i in 0 ..< 9 {
            let btn = UIButton(type: UIButtonType.Custom);
            btn.setImage(UIImage(named: "gesture_node_normal"), forState: UIControlState.Normal);
            btn.setImage(UIImage(named: "gesture_node_highlighted"), forState: UIControlState.Selected);
            btn.tag = 10000+i;
            btn.userInteractionEnabled = false;
            self.addSubview(btn);
        }
    }
//MARK: - public 
    func renewOriginalStatus() {
        if btnsArray.count > 0 {
            for (index,_) in btnsArray.enumerate() {
                let btn = btnsArray[index];
                btn.selected = false;
            }
            btnsArray.removeAll(keepCapacity: false);
        }
        self.setNeedsDisplay();
    }
    
}
