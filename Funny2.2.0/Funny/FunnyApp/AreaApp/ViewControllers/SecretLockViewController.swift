//
//  SecretLockViewController.swift
//  Funny
//
//  Created by yanzhen on 16/1/5.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit
import LocalAuthentication

class SecretLockViewController: UIViewController,LockViewProtocol {

    @IBOutlet private weak var lockView: LockView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBarHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lockView.delegate = self;
        let context = LAContext();
        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil) {
            let vc = SecretRecordViewController(nibName: "SecretRecordViewController", bundle: nil);
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
    
    func lockPasswordString(password: String) {
        
        var pw1: String? = nil;
        let pwStr = NSUserDefaults.standardUserDefaults().objectForKey(AREAPASSWORD) as? String;
        if pwStr != nil {
            pw1 = pwStr;
        } else {
            pw1 = AREAPASSWORD1;
        }
        
        if password == pw1 || password == AREAPASSWORD2 {
            let vc = SecretRecordViewController(nibName: "SecretRecordViewController", bundle: nil);
            self.navigationController?.pushViewController(vc, animated: true);
        }else{
            self.view.makeCenterToast("密码错误,请重新输入");
            lockView.renewOriginalStatus();
        }

    }
    
    
    @IBAction func exitBtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
}
let AREAPASSWORD = "AreaPassword";
let AREAPASSWORD1 = "24658";
let AREAPASSWORD2 = "028635147";