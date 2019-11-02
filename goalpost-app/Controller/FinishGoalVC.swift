//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Ahmed on 10/28/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var createGoalTF: UIButton!
    var goalDescription : String!
    var goalType : GoalType!
    func initMyVariables(desc : String , type : GoalType)
    {
        self.goalDescription = desc
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalTF.bindToKeyboard()
        pointsNeeded.delegate = self
    }
  
    @IBAction func BackButtonPressed(_ sender: Any) {
      AnimateVCDown()
    }
    
    @IBOutlet weak var pointsNeeded: UITextField!
    @IBAction func CreateGoalButtonPressed(_ sender: Any) {
        if pointsNeeded.text != ""{
        self.saveData { (complete) in
            if(complete)
            {
            dismiss(animated: true, completion: nil )
            }
        }
        }
    }


    func saveData(handler : (_ status : Bool)->())
    {
     // passing a Mangedcontext to know where is saving data
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalTypeTerm = goalType.rawValue
        goal.gaolCompletedValue = Int32(pointsNeeded.text!)!
        goal.gaolProcess = Int32(0)
        
        do{
           // commit changes to parent store
      try  managedContext.save()
            handler(true)
        }
        catch
        {
            debugPrint("could'nt Sava :\(error.localizedDescription) ")
                handler(false)
            }
        }







}
