//
//  CollectableTableViewController.swift
//  Collector
//
//  Created by Nikhil Ranjan on 08/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class CollectableTableViewController: UITableViewController {
    var allCollected = [Collectable]()
    
    /*It will always called when view is loaded*/
    override func viewWillAppear(_ animated: Bool) {
        getAllCollected()
    }
    
    /*Get allCollected from core data*/
    func getAllCollected(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let collectableData = try? context.fetch(Collectable.fetchRequest()){
                if let collectables = collectableData as? [Collectable]{
                    allCollected = collectables
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCollected.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        let current = allCollected[indexPath.row]
        if let title = current.title {
            cell.textLabel?.text = title
            if let imageData = current.image {
                // convert binary data to UIImage
                cell.imageView?.image = UIImage(data: imageData)
            }
        }
        return cell
    }
    /*deselect row selected*/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*Delete on swipe */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                let collectable = allCollected[indexPath.row]
                context.delete(collectable)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getAllCollected()
            }
        }
    }
}
