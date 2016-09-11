//
//  SentMemesTableViewController.swift
//  MeMefy
//
//  Created by Pushkar Sharma on 11/09/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath)
        cell.imageView?.contentMode = .ScaleAspectFit
        cell.imageView?.image = memes[indexPath.row].processedImage
        cell.textLabel?.text = memes[indexPath.row].topText + " " + memes[indexPath.row].bottomText
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detailViewSegue", sender: indexPath.row)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailViewSegue" {
            let dest = segue.destinationViewController as! MemeDetailViewController
            let index = sender as! Int
            let meme = memes[index]
            dest.memeImage = meme.processedImage
        }
    }
}
