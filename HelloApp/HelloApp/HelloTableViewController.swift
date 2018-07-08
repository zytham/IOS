//
//  HelloTableViewController.swift
//  HelloApp
//
//  Created by Nikhil Ranjan on 08/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {
    var hellos = [Hello]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*It will always called when view is loaded*/
    override func viewWillAppear(_ animated: Bool) {
        getHellos()
    }
    
    /*Get data from coreData*/
    func getHellos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let helloFromCoreData = try? context.fetch(Hello.fetchRequest()){
                if let helloDs = helloFromCoreData as? [Hello]{
                    hellos = helloDs
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return hellos.count
    }

    //Create Hello on click of plus
    @IBAction func addClick(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let _ = Hello(context: context)
            //newHello.name = "Hello"
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
    // Delete row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hello = hellos[indexPath.row]
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            context.delete(hello)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
    
    //create row - called for each hellowrows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hello = hellos[indexPath.row]
        cell.textLabel?.text = hello.name
        return cell
    }
}
