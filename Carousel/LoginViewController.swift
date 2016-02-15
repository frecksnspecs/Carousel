//
//  LoginViewController.swift
//  Carousel
//
//  Created by Sam Huskins on 2/14/16.
//  Copyright © 2016 Sam Huskins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var fieldInitialY: CGFloat!
    var fieldOffset: CGFloat!
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScrollView.delegate = self

        loginScrollView.contentSize = loginScrollView.frame.size
        loginScrollView.contentInset.bottom = 100
        
        //fieldInitialY = fieldParentView.frame.origin.y
        //fieldOffset = -120
        
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        fieldParentView.frame.origin.y = fieldInitialY + fieldOffset
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        loginScrollView.contentOffset.y = loginScrollView.contentInset.bottom


    }
    
    func keyboardWillHide(notification: NSNotification!) {
        buttonParentView.frame.origin.y = buttonInitialY


    }

    @IBAction func onSignIn(sender: AnyObject) {
        
        let emptyAlertController = UIAlertController(title: "Email Required", message: "Please enter your email address", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) {
            (action) in
            // handle cancel response here. doing nothing will dismiss view
        }
        emptyAlertController.addAction(cancelAction)

        let invalidAlertController = UIAlertController(title: "Invalid Email or Password", message: "Please enter a valid Email and Password", preferredStyle: .Alert)
        let invalidAction = UIAlertAction(title: "OK", style: .Cancel) {
            (action) in
            // handle cancel response here. doing nothing will dismiss view
        }
        invalidAlertController.addAction(invalidAction)

        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.activityIndicatorView.stopAnimating()
            self.presentViewController(emptyAlertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        } else if emailTextField.text == "sam@lyft.com" && passwordTextField.text == "123" {
            self.activityIndicatorView.startAnimating()
            delay(2, closure: { () -> () in
                self.activityIndicatorView.stopAnimating()
                self.performSegueWithIdentifier("welcomeSegue", sender: self)
            })
            
        } else {
            self.activityIndicatorView.startAnimating()
            delay(2, closure: { () -> () in
                self.activityIndicatorView.stopAnimating()
                self.presentViewController(invalidAlertController, animated: true) {
                }
            })
                // optional code for what happens after the alert controller has finished presenting
        }
        

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
