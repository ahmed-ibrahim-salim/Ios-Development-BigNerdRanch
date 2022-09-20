//
//  ItemsViewController.swift
//  BigNerdRanchProjects
//
//  Created by Ahmad medo on 15/09/2022.
//

import UIKit

class ItemsViewController: UIViewController {
    
    var itemStore: ItemStore!
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        itemsTableView.rowHeight = UITableView.automaticDimension
        itemsTableView.estimatedRowHeight = 65
        
        print("Hello world")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showItem" :
            if let row = itemsTableView.indexPathForSelectedRow?.row{
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    @IBAction func addNewItem(_ sender: UIButton) {
        
        let item = itemStore.createItem()
        if let index = itemStore.allItems.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            
            itemsTableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if itemsTableView.isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            // Turn off editing mode
            itemsTableView.setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            // Enter editing mode
            itemsTableView.setEditing(true, animated: true)
        }
    }
}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        
        cell.serialNumberLabel.text = item.serialNumber
        cell.nameLabel.text = item.name
        
        
        cell.valueLabel.text = "$ \(item.valueInDollars)"
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            
            itemStore.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
}
