//
//  JokeTableControllerTableViewController.swift
//  JokeBank
//
//  Created by Nikhil Ranjan on 07/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class JokeTableControllerTableViewController: UITableViewController {

    //Joke data
    var jokes: [Joke] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let joke1 = Joke();
        joke1.title = "Chiken"
        joke1.text  = "Chieken joke"
        
        let joke2 = Joke();
        joke2.title = "Walk into bar"
        joke2.text  = "Walk into bar joke"
        
        let joke3 = Joke();
        joke3.title = "Olives"
        joke3.text  = "Olives joke"
        
        jokes = [joke1, joke2, joke3]
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //HOW MANY ?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    //WHAT GOES INSIDE
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        // display index for each joke
        // print(indexPath.row)
        cell.textLabel?.text = jokes[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let selectedJoke = jokes[indexPath.row]
        performSegue(withIdentifier: "MoveToJokeDetails", sender: selectedJoke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let jokeVC = segue.destination as? JokeDetailsViewController{
            if let selectedJoke = sender as? Joke{
                jokeVC.joke = selectedJoke
            }
        }
    }
    
}
