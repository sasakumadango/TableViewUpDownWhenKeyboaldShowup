// 
//  TableViewCell.swift
//  TableViewUpDownWhenKeyboaldShowup
//
//  Created by Yuta S. on 2021/02/06.
//  Copyright © 2021 Yuta S. All rights reserved.
//
//

import UIKit


class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var myTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myTextField.delegate = self
    }
}

extension TableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
