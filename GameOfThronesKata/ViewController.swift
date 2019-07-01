//
//  ViewController.swift
//  GameOfThronesKata
//
//  Created by Wilmar van Heerden on 2017/08/18.
//  Copyright © 2017 Glucode. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UITableViewController {
    
    fileprivate let viewModel = InfoViewModel()
    
    @IBOutlet weak var customNavigationBar: UINavigationItem!
    @IBOutlet var customTableView: UITableView!
    
    var characterDetail: GRKCharacterDetailResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting nav bar title
        customNavigationBar.title = characterDetail?.name
        
        customTableView?.dataSource = viewModel
        
        customTableView?.estimatedRowHeight = 100
        customTableView?.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = CGFloat()
        height = 150.00
        
        return height
    }
}
