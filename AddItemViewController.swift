//
//  AddItemViewController.swift
//  trader
//
//  Created by Xi Zhang on 12/3/15.
//  Copyright © 2015 minor. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var idTextField: UITextField!
    
    var item:Item?;
    
    
    override func viewDidLoad() {
        validateItem();
        
        idTextField.delegate = self;
    }
    
    func validateItem() {
        doneBtn.enabled = idTextField.text != nil &&  Int(idTextField.text!) != nil;
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender === doneBtn) {
            if let id = Int(idTextField.text ?? "") {
                item = Item(id: id);
            }
        }
    }
    
    
    //textfield delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        doneBtn.enabled = false;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        validateItem();
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        idTextField.endEditing(true);
    }
}
