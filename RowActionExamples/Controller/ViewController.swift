//
//  ViewController.swift
//  RowActionExamples
//
//  Created by Brett Chapin on 2/19/18.
//  Copyright © 2018 Black Rose Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    // IBOutlets
    @IBOutlet weak var starTable: UITableView!
    
    // Class Properties
    var infoForCells: [(title: String, isStarred: Bool)] = [("Item0", false),
                                                            ("Item1", false),
                                                            ("Item2", false),
                                                            ("Item3", false),
                                                            ("Item4", false),
                                                            ("Item5", false),
                                                            ("Item6", false),
                                                            ("Item7", false),
                                                            ("Item8", false),
                                                            ("Item9", false)]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starTable.delegate = self
        starTable.dataSource = self
    }
    
    // MARK: - TableView Delegate and Datasource Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoForCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath) as! StarCell
        cell.configure(cellItem: infoForCells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // There are 3 Forms of UITableViewActions you can make, and I'll illustrate them below
        let starred = infoForCells[indexPath.row].isStarred
        var starTitle = ""
        if starred {
            starTitle = "UnStar"
        } else {
            starTitle = "Star"
        }
        
        let starAction = UITableViewRowAction(style: .normal, title: starTitle) { (action, indexPath) in
            self.infoForCells[indexPath.row].isStarred = !self.infoForCells[indexPath.row].isStarred
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let duplicateAction = UITableViewRowAction(style: .default, title: "Duplicate") { (action, indexPath) in
            var duplicatedItem = self.infoForCells[indexPath.row]
            duplicatedItem.title = "\(duplicatedItem.title) copy"
            self.infoForCells.insert(duplicatedItem, at: indexPath.row + 1)
            let indexPathForNew = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            tableView.insertRows(at: [indexPathForNew], with: .bottom)
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.infoForCells.remove(at: indexPath.row)
            let indexPathForDelete = IndexPath(row: indexPath.row, section: indexPath.section)
            tableView.deleteRows(at: [indexPathForDelete], with: .automatic)
        }
        
        return [deleteAction, duplicateAction, starAction]
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let duplicateAction = UIContextualAction(style: .normal, title: "Duplicate") { (action, view, handler) in
            var duplicatedItem = self.infoForCells[indexPath.row]
            duplicatedItem.title = "\(duplicatedItem.title) copy"
            self.infoForCells.insert(duplicatedItem, at: indexPath.row + 1)
            let indexPathForNew = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            tableView.insertRows(at: [indexPathForNew], with: .bottom)
            handler(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.infoForCells.remove(at: indexPath.row)
            let indexPathForDelete = IndexPath(row: indexPath.row, section: indexPath.section)
            tableView.deleteRows(at: [indexPathForDelete], with: .automatic)
            handler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, duplicateAction])
        
        return configuration
    }
    
    func doThis() {
        print("Hello World!")
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let starred = infoForCells[indexPath.row].isStarred
        var starTitle = ""
        if starred {
            starTitle = "UnStar"
        } else {
            starTitle = "Star"
        }
        
        let starAction = UIContextualAction(style: .normal, title: starTitle) { (action, view, handler) in
            self.infoForCells[indexPath.row].isStarred = !self.infoForCells[indexPath.row].isStarred
            tableView.reloadRows(at: [indexPath], with: .automatic)
            handler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [starAction])
        
        return configuration
    }


}

