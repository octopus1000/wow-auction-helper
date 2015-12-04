//
//  FirstViewController.swift
//  trader
//
//  Created by Xi Zhang on 11/30/15.
//  Copyright © 2015 minor. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var itemsForSale = [Item]();
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedItem = loadItemData() {
            itemsForSale += savedItem;
        }
        
        //navigationItem.leftBarButtonItem = editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //table delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsForSale.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "CellDisplay";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! CellDisplay;
        let item = itemsForSale[indexPath.row];
        
        cell.itemName.text = item.name;
        cell.itemBuyoutPrice.text = String(item.buyout);
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //update model
            itemsForSale.removeAtIndex(indexPath.row);
            saveItemData();
            //update view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade);
        }
    }
    
    //support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showStatistics", sender: itemsForSale[indexPath.row].id);
    }
    
    //load Item data into itemsForSale
    func loadItemData() -> [Item]?{
         return NSKeyedUnarchiver.unarchiveObjectWithFile(Item.ArchiveURL.path!) as? [Item]
    }
    
    func saveItemData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(itemsForSale, toFile: Item.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showStatistics" ,let dstController = segue.destinationViewController as? StatisticViewController {
            let id = sender as! Int;
            dstController.itemId = id;
        }
    }
    
    //exec when segue backward from AddItemViewController
    //add new item to list
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let srcViewController = sender.sourceViewController as? AddItemViewController, item = srcViewController.item {
            
            if itemsForSale.contains(item) {
                return;
            }
            
            let newIndexPath = NSIndexPath(forRow: itemsForSale.count, inSection: 0);
            //update model
            itemsForSale.append(item);
            //update view
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom);
        }
        
        saveItemData();
    }

}

