//
//  CompleteViewController.swift
//  ToDoList
//
//  Created by Nikhil Ranjan on 07/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    var toDoInput : ToDo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelText.text = toDoInput?.name
        if let theToDo = toDoInput {
            if theToDo.isImportant {
                if let name = theToDo.name {
                    labelText.text = "❗️" + name
                }
            }else{
                labelText.text = theToDo.name
            }
        }
        
    }
    @IBAction func tappedComplete(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let delToDoIn = toDoInput {
                context.delete(delToDoIn)
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        //Go back to previous view controller
        navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
