//
//  File.swift
//  persistent_bucket_list
//
//  Created by Jim Lambert on 11/5/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit

protocol CancelButtonDelegate: class {
    func save(_ item: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: UIViewController)
}

