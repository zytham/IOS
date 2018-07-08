//
//  JokeDetailsViewController.swift
//  JokeBank
//
//  Created by Nikhil Ranjan on 07/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class JokeDetailsViewController: UIViewController {
    var joke = Joke()
    @IBOutlet weak var jokeQ: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = joke.title
        jokeQ.text = joke.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
