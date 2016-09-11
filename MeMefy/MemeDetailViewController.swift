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
    
    var memeImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = memeImage
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
