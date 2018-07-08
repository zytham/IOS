//
//  ToDOListTableTableViewController.swift
//  ToDoList
//
//  Created by Nikhil Ranjan on 07/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class ToDOListTableTableViewController: UITableViewController {
    //todo data
    //var toDos: [ToDo] = []
    var toDoCoreDatas = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /*It will always called when view is loaded*/
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    /*Get data from core data*/
    func getToDos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let toDoFromCoreData = try? context.fetch(ToDo.fetchRequest()){
                if let toDos = toDoFromCoreData as? [ToDo]{
                   toDoCoreDatas = toDos
                    tableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //How many
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCoreDatas.count
    }

    /*It iterate for all todos item*/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        let currentToDo = toDoCoreDatas[indexPath.row]
        if currentToDo.isImportant {
            if let name = currentToDo.name {
                cell.textLabel?.text = "❗️" + name
            }
        }else{
            cell.textLabel?.text = currentToDo.name
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        let selectedToDo = toDoCoreDatas[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: selectedToDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createVC = segue.destination as? CreateToDoViewController {
            //To pass current class to next controller
            createVC.todoTableVC = self
        }
        
        if let completeVC = segue.destination as? CompleteViewController{
            if let selectedToDo = sender as? ToDo{
                completeVC.toDoInput = selectedToDo
            }
        }
    }
}
