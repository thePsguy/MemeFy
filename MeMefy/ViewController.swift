//
//  ViewController.swift
//  MeMefy
//
//  Created by Pushkar Sharma on 09/09/2016.
//  Copyright © 2016 thePsguy. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var libraryButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = false
        initMemeTextFields()
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()

    }

    @IBAction func pickerTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if sender.tag == 0{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }

        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:))    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:))    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }

    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.isFirstResponder(){
            view.frame.origin.y = -1 * getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func getMeme() -> Meme {
        //Create the meme
        let meme = Meme.init(topText: topText.text!, bottomText: bottomText.text!, rawImage: imageView.image!, processedImage: generateMemedImage())
        return meme
    }
    
    func generateMemedImage() -> UIImage
    {
        toolBar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        
        return memedImage
    }

}



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image: UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        imageView.image = image
        
        shareButton.enabled = true
        topText.hidden = false
        bottomText.hidden = false
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func downloadTapped(sender: AnyObject) {
//        imageView.image = meme.processedImage
        let nextController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        self.presentViewController(nextController, animated: true, completion: nil)
        
        nextController.completionWithItemsHandler = {(activityType, completed:Bool, returnedItems:[AnyObject]?, error: NSError?) in
            if (!completed) {
                return
            }
            self.saveMeme()
            print("Meme object creaated.")
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func saveMeme() {
        //Create the meme
        let meme = getMeme()
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func initMemeTextFields(){
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -5
        ]
        
        func setTextField(field: UITextField){
            field.hidden = true
            field.defaultTextAttributes = memeTextAttributes
            field.textAlignment = NSTextAlignment.Center
            field.text = field.tag==0 ? "TOP TEXT" : "BOTTOM TEXT"
            field.borderStyle = UITextBorderStyle.None
            field.delegate = self
        }
        setTextField(topText)
        setTextField(bottomText)
    
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("did end")
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}

