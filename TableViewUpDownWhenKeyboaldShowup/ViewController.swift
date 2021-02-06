// 
//  ViewController.swift
//  TableViewUpDownWhenKeyboaldShowup
//
//  Created by Yuta S. on 2021/02/06.
//  Copyright © 2021 Yuta S. All rights reserved.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        if let selectedIndexPath = self.myTableView.indexPathForSelectedRow,
           let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.myTableView.contentInset.bottom == 0.0 {
                self.myTableView.contentInset.bottom += keyboardSize.height
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.myTableView.scrollToRow(at: selectedIndexPath, at: .middle, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide() {
        if self.myTableView.contentInset.bottom != 0.0 {
            self.myTableView.contentInset.bottom = 0.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = indexPath.row.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.myTextField.becomeFirstResponder()
    }
}

