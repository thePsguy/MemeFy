//
//  MemeDetailViewController.swift
//  MeMefy
//
//  Created by Pushkar Sharma on 11/09/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = meme.processedImage
        
        self.tabBarController?.tabBar.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    
//    @IBAction func editMeme(sender: AnyObject) {
//        
//        performSegueWithIdentifier("editMeme", sender: nil)
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editMeme"){
            let dest = segue.destinationViewController as! EditMemeViewController
            dest.incomingMeme = meme
        }
    }

}
