//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Ahmed on 10/27/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

  
    @IBOutlet weak var descGaol: UILabel!
    
    @IBOutlet weak var termType: UILabel!
    
    @IBOutlet weak var goelProgress: UILabel!
    
    @IBOutlet weak var goalCompletedView: UIView!
    
    func initCell(goal : Goal )
    {
        self.descGaol.text = goal.goalDescription
        self.termType.text = goal.goalTypeTerm
        self.goelProgress.text = String(describing : goal.gaolProcess)
    
        if goal.gaolProcess == goal.gaolCompletedValue{
            self.goalCompletedView.isHidden = false
        }else
        {
            self.goalCompletedView.isHidden = true
        }
        
    
    }
}
