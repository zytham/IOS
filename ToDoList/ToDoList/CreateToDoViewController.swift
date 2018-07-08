//
//  CreateToDoViewController.swift
//  ToDoList
//
//  Created by Nikhil Ranjan on 07/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class CreateToDoViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    var todoTableVC : ToDOListTableTableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddTodo(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let newTodo = ToDo(context: context)
            newTodo.isImportant = importantSwitch.isOn
            if let name = nameTextField.text {
                newTodo.name = name
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        //let newTodo = ToDo()
        
       
//        todoTableVC?.toDos.append(newTodo)
//        todoTableVC?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }

}
