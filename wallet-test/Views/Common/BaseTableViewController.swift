//
//  BaseTableViewController.swift
//  wallet-test
//
//  Created by John Paulo on 6/10/22.
//

import UIKit
import Network

class BaseTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    // MARK: - Setup
    
    /// Register cells to be used by the table view
    func registerCells() {
        preconditionFailure("This method must be overridden")
    }
    
    // MARK: - Methods
    
    // Show default system alert with title and message
    func showDefaultAlert(title: String?, message: String?, _ completion: (()-> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
