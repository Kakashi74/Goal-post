//
//  CreateGaolVC.swift
//  goalpost-app
//
//  Created by Ahmed on 10/28/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class CreateGaolVC: UIViewController , UITextViewDelegate {
    
    @IBOutlet weak var shortTermBtn: UIButton!
    
    @IBOutlet weak var longTermBtn: UIButton!
    
    @IBOutlet weak var goalTextView: UITextView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var gType : GoalType = .longTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        longTermBtn.selectedBtn()
        shortTermBtn.deSelectedBtn()
        nextBtn.bindToKeyboard()
        goalTextView.delegate = self
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        
      AnimateVCDown()
        
    }
    @IBAction func ShortTermBtnPressed(_ sender: Any) {
        gType = .shortTerm
        shortTermBtn.selectedBtn()
        longTermBtn.deSelectedBtn()
    }
    
    @IBAction func LongTermBtnPressed(_ sender: Any) {
        gType = .longTerm
        shortTermBtn.deSelectedBtn()
        longTermBtn.selectedBtn()
    }
    
    @IBAction func NextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "Hi there , what is your goal"
        {
            guard let finishGoalVC = storyboard?.instantiateViewController(identifier: "FinishGoalVC") as? FinishGoalVC else {return}
            finishGoalVC.initMyVariables(desc: goalTextView.text!, type: gType)
           // AnimateVCUP(finishGoalVC)
            presentingViewController?.secandryPresentVC(finishGoalVC)
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
