//
//  SecondTableViewCell.swift
//  GameOfThronesKata
//
//  Created by Oscar on 2019/01/21.
//  Copyright © 2019 Glucode. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOfCharacterLbl: UILabel!
    @IBOutlet weak var dateOfBirthCharacterLbl: UILabel!
    
    var item: Sibling? {
        didSet {
            nameOfCharacterLbl?.text = item?.name
            dateOfBirthCharacterLbl?.text = item?.dateOfBirth
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
