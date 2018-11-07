//
//  ViewController.swift
//  persistent_bucket_list
//
//  Created by Jim Lambert on 11/5/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, CancelButtonDelegate {
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bob", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let navControl = segue.destination as! UINavigationController
            let addControl = navControl.topViewController as! addItemTableViewController
            addControl.delegate = self
        } else if sender is NSIndexPath {
            let navControl = segue.destination as! UINavigationController
            let addControl = navControl.topViewController as! addItemTableViewController
            addControl.delegate = self
            let indexPath = sender as! NSIndexPath
            addControl.current = items[indexPath.row].text!
            addControl.indexPath = indexPath
        }
    }
    
    func fetchAllItems() {
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        let request: NSFetchRequest<BucketListItem> = BucketListItem.fetchRequest()
        do {
            //let result = try managedObjectContext.fetch(request)
            //items = result as! [BucketListItem]
            items = try managedObjectContext.fetch(request)
        } catch {
            print("Error! \(error)")
        }
    }
    
    func cancelButtonPressed(by controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    } // runs when cancel button is pressed by add view
    
    func save(_ newText:String, at indexPath: NSIndexPath?){
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = newText
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = newText
            items.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Error! \(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    } // runs when save button is pressed by add view
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "bob", sender: indexPath)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "bob", sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("Error! \(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

