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
        
        joke1.text  = "Q: Did you hear about the chicken who could only lay eggs in the winter?\nA: She was no spring chicken.\n\nQ: Why does a chicken coop have two doors?\nA: Because if had four doors it would be a chicken sedan!\n\nQ: Psychiatrist: What seems to be the problem?\nA:Patient: I think I’m a chicken.\nPsychiatrist: How long has this been going on?\nPatient: Ever since I came out of my shell."
        let joke2 = Joke();
        joke2.title = "Walk into bar"
        joke2.text  = "A neutron walks into a bar and orders a drink. When the neutron gets his drink, he asks, Bartender, how much do I owe you?\nThe bartender replies, For you, neutron, no charge."
        
        let joke3 = Joke();
        joke3.title = "Olives"
        joke3.text  = "A guy walks into the doctor's office. A banana stuck in one of his ears, a asparagus stalk in the other ear, and an olive stuck in one nostril. The man says, Doc, this is terrible. What's wrong with me? The doctor says, Well, first of all, you need to eat more sensibly.\n\nA lizard walks into a bar pushing a baby in a stroller. What's your kid's name? asks the bartender. Tiny,says the lizard. Because he's my newt."
        
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
