//
//  addItemTableViewController.swift
//  persistent_bucket_list
//
//  Created by Jim Lambert on 11/5/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit

class addItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = current
    }

    @IBOutlet weak var textField: UITextField!
    weak var delegate: CancelButtonDelegate?
    var indexPath: NSIndexPath?
    var current: String?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if textField.text!.count > 0 {
            delegate?.save(textField.text!, at: indexPath)
        } else {
            delegate?.cancelButtonPressed(by: self)
        }
    }
    
}
