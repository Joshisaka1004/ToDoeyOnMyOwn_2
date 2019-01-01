//
//  ViewController.swift
//  ToDoeyOnMyOwn_2
//
//  Created by Joachim Vetter on 01.01.19.
//  Copyright © 2019 Joachim Vetter. All rights reserved.
//

import UIKit

class MyTableVC: UITableViewController {
    
    var myPuzzleFamilies = ["Sudoku", "Kakuro", "Hakyuu", "Skyscrapers"]

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPuzzleFamilies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCells", for: indexPath)
        myCell.textLabel?.text = myPuzzleFamilies[indexPath.row]
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func myAddButton(_ sender: UIBarButtonItem) {
        
        var myRealTextField = UITextField()
        
        let myAlertVC = UIAlertController(title: "Add Puzzle", message: "", preferredStyle: .alert)
        let myAlertAction = UIAlertAction(title: "we have added your request!", style: .default) { (action) in
            self.myPuzzleFamilies.append(myRealTextField.text!)
            self.defaults.set(self.myPuzzleFamilies, forKey: "myToDoList")
            self.tableView.reloadData()
        }
        myAlertVC.addTextField { (myTextField) in
            myTextField.placeholder = "Give your wish"
            myRealTextField = myTextField
        }
        
        myAlertVC.addAction(myAlertAction)
        present(myAlertVC, animated: true, completion: nil)
    }
}

