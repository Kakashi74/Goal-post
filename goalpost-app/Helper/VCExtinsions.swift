//
//  VCExtinsions.swift
//  goalpost-app
//
//  Created by Ahmed on 10/28/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func AnimateVCUP(_ VCAnimtae : UIViewController)
    {
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.duration = 0.3
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(VCAnimtae ,animated : false ,completion:  nil)
    }
    func secandryPresentVC(_ viewcontroller : UIViewController){
        let transition = CATransition()
               transition.type = kCATransitionPush
               transition.duration = 0.3
               transition.subtype = kCATransitionFromRight
              
        guard let presentedVC = presentedViewController else {return}
        presentedVC.dismiss(animated: false) {
             self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewcontroller, animated: false, completion: nil)
            
        }}
    
    func AnimateVCDown()
       {
           let transition = CATransition()
           transition.type = kCATransitionPush
           transition.duration = 0.3
           transition.subtype = kCATransitionFromLeft
           self.view.window?.layer.add(transition, forKey: kCATransition)
           
           dismiss(animated: false, completion: nil)
       }
}

extension UIView {
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func KeyboardWillChanged(_ notification : NSNotification)
    {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue ).cgRectValue
        let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue ).cgRectValue
        let deltaY = endingFrame.origin.y - startingFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue : curve), animations: {
            self.frame.origin.y += deltaY
        }, completion:  nil)
    }
}

extension UIButton
{
    func selectedBtn(){
        self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
    }
func deSelectedBtn()
{
     self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    
    }
}














