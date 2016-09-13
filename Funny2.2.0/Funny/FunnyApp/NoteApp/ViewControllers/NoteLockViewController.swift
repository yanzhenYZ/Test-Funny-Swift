//
//  NoteLockViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/18.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit
import LocalAuthentication

class NoteLockViewController: SuperSecondViewController {

    private var lockView: NumLockView!
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.notePasswordIsRight), name: PASSWORDISRIGHT, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.notePasswordIsWrong), name: PASSWORDISWRONG, object: nil);
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    override func viewDidLoad() {
        
        self.title = "备忘录";
        // Do any additional setup after loading the view.
        lockView = NumLockView(frame: CGRectZero);
        lockView.backgroundColor = FunnyManager.manager.color(40.0, G: 34.0, B: 37.0);
        lockView.smallViewBorderColor = FunnyManager.manager.color(89.0, G: 76.0, B: 102.0);
        lockView.btnBorderColor = FunnyManager.manager.color(89.0, G: 76.0, B: 102.0);
        
        let pwStr = NSUserDefaults.standardUserDefaults().objectForKey(NOTEPASSWORD) as? String;
        if pwStr != nil {
            lockView.password = pwStr;
        }
        self.view.addSubview(lockView);
        super.viewDidLoad()
        
        let context = LAContext();
        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            let vc = NoteShowViewController(nibName: "NoteShowViewController", bundle: nil);
            unowned let blockSelf = self
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: NSLocalizedString("Touch ID密码", comment: ""), reply: { (success, error) in
                if success {
                    dispatch_async(dispatch_get_main_queue(), {
                        blockSelf.navigationController?.pushViewController(vc, animated: true);
                    })
                }else{
                    if Int32(error!.code) == kLAErrorUserFallback {
                        //
                    }else if Int32(error!.code) == kLAErrorUserCancel {
                        //手动取消
                    }else{
                        //失败
                    }
                }
            })
        }
    }

    func notePasswordIsRight() {
        let vc = NoteShowViewController(nibName: "NoteShowViewController", bundle: nil);
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func notePasswordIsWrong() {
        
    }
   
}
let NOTEPASSWORD = "notePassword";