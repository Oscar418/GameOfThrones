//
//  FirstTableViewCell.swift
//  GameOfThronesKata
//
//  Created by Oscar on 2019/01/21.
//  Copyright © 2019 Glucode. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterTitleLbl: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    
    var item: InfoViewModelItem? {
        didSet {
            guard let item = item as? ProfileViewModelAboutItem else {
                return
            }
            
            characterTitleLbl?.text = item.characterTitle
            characterStatus?.text = item.characterStatus
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
