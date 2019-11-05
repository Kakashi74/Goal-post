//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Ahmed on 10/26/19.
//  Copyright © 2019 AhmedDev. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
    var goals : [Goal] = []

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         fetchCoreDataObjects()
          tableView.reloadData()
          }
    
    func fetchCoreDataObjects()
    {
        self.fetchRequest { (complete) in
                 if complete {
                     if goals.count >= 1
                     {
                         tableView.isHidden = false
                     }  else
                     {
                         tableView.isHidden = true
                     }
                 }
             }
    }
    
    @IBAction func addGoalBtn(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC") as? CreateGaolVC else {return}
        AnimateVCUP(createGoalVC)
    }
    
}

extension GoalsVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "gaolCell") as? GoalCell else{ return GoalCell() }
        let goal = goals[indexPath.row]
        cell.initCell(goal: goal)
        
        return cell
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let actionDelete = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            
            self.remove(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let progressAction  = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        actionDelete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        progressAction.backgroundColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
        
        return [actionDelete , progressAction]
    }

}
extension GoalsVC {
    func setProgress(atIndexPath indexPaht : IndexPath){
     
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
          
        let chosenGoal = goals[indexPaht.row]
        
        if chosenGoal.gaolCompletedValue > chosenGoal.gaolProcess {
            chosenGoal.gaolProcess = chosenGoal.gaolProcess + 1
        }
        else {return}
        do
               {
                  try managedContext.save()
               }
               catch{
                   debugPrint("Error Could Not save\(error.localizedDescription)")
               }
        
    }
    
    
    
    func remove(atIndexPath indexPath : IndexPath)
    {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexPath.row])
        do
        {
           try managedContext.save()
        }
        catch{
            debugPrint("Error Could Not save\(error.localizedDescription)")
        }
        
    }
    
    
    
    func fetchRequest( completion :(_ completion : Bool) -> ()){
       guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do
        {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
        }
        catch{
            debugPrint("Error \(error.localizedDescription)")
        completion(false)
        }
        
        
    }
}
